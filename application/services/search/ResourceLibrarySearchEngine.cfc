/**
 * @singleton
 * @presideService
 */
component {

// CONSTRUCTOR
	/**
	 * @elasticSearchEngine.inject     ElasticSearchEngine
	 * @elasticSearchApiWrapper.inject ElasticSearchApiWrapper
	 */

	public any function init(
		  required any elasticSearchEngine
		, required any elasticSearchApiWrapper
	) {
		_setElasticSearchEngine( arguments.elasticSearchEngine     );
		_setElasticSearchApi(    arguments.elasticSearchApiWrapper );

		return this;
	}

// PUBLIC METHODS
	public any function search(
		  string  q                          = "*"
		, numeric page                       = 1
		, numeric pageSize                   = 10
		, string  category           		 = ""
		, string  region            		 = ""
		, string  fieldList                  = "id,title,slug,teaser,description,access_restricted,category,region"
	) {

		var args             = Duplicate( arguments );

		args.objects         = [ "resource_library_resource" ];
		args.sortOrder       = "title ASC";
		args.defaultOperator = "AND";
		args.pageSize        = arguments.pageSize;

		if ( !Len( Trim( args.q ) ) ) {
			args.q = "*";
		}

		args.fullDsl        = _getElasticSearchApi().generateSearchDsl( argumentCollection=args );
		// {
		// 	"query"  : { "match_all": {} },
		// 	"fields" : ["id","title","slug","teaser","description","access_restricted","category","region"],
		// 	"from"	 : 0,
		// 	"size"	 : 10,
		// 	"sort"	 : { "title": { "order": "desc" } }
		// }

		args.fullDsl.filter = _getFilterDsl(
			  category = arguments.category
			, region   = arguments.region
		);
		// {
		// 	... ...

		// 	"filter" : {
		// 		"bool" : {
		// 			"must" : [
		// 				{
		// 					"term" : {
		// 						"category" : listToArray(arguments.category)
		// 					}
		// 				},
		// 				{
		// 					"term" : {
		// 						"region" : listToArray(arguments.region)
		// 					}
		// 				}
		// 			]
		// 		}
		// 	}
		// }

		_addAggregationsDsl( args.fullDsl  );
		// {
		// 	... ...

		// 	"aggs" : {
		// 		"filtered" : {
		// 			"aggs" : {
		// 				"category" : {
		// 					"terms" : {
		// 						"field" : "category",
		// 						"order" : { "_term": "desc" },
		// 						"size"	: 50
		// 					}
		// 				},
		// 				"region" : {
		// 					"terms" : {
		// 						"field" : "region",
		// 						"order" : { "_term": "desc" },
		// 						"size"	: 50
		// 					}
		// 				}
		// 			},
		// 			"filter" : {
		// 				"bool" : {
		// 					"must" : [
		// 						{
		// 							"terms" : {
		// 								"category" : listToArray(arguments.category)
		// 							}
		// 						},
		// 						{
		// 							"terms" : {
		// 								"region" : listToArray(arguments.region)
		// 							}
		// 						}
		// 					],
		// 					"must_not" : [],
		// 					"should"   : []
		// 				}
		// 			}
		// 		}
		// 	}
		// }

		var results = _getElasticSearchEngine().search( argumentCollection=args );
		// results.getAggregations() =
		// {
		// 	"category" : {
		// 		... ... ,
		// 		... ... ,
		// 		"buckets" : [
		// 			{
		// 				"key" : *first_category_id*,
		// 				"doc_count" : *number_of_documents_with_first_category_id*,
		// 			},
		// 			... ... ,
		// 			{
		// 				"key" : *last_category_id*,
		// 				"doc_count" : *number_of_documents_with_last_category_id*,
		// 			}
		// 		]
		// 	},
		// 	"region" : {
		// 		... ... ,
		// 		... ... ,
		// 		"buckets" : [
		// 			{
		// 				"key" : *first_region_id*,
		// 				"doc_count" : *number_of_documents_with_first_region_id*,
		// 			},
		// 			... ... ,
		// 			{
		// 				"key" : *last_region_id*,
		// 				"doc_count" : *number_of_documents_with_last_region_id*,
		// 			}
		// 		]
		// 	}
		// }
		_translateAggregation( results.getAggregations() );
		// result.getAggregations() =
		// {
		// 	"category" : [
		// 		{
		// 			"key" : *first_category_id*,
		// 			"doc_count" : *doc_count_for_first_category*,
		// 			"label" : *label_for_first_category*
		// 		},
		// 		... ... ,
		// 		{
		// 			"key" : *last_category_id*,
		// 			"doc_count" : *doc_count_for_last_category*,
		// 			"label" : *label_for_last_category*
		// 		}
		// 	],
		// 	"region" : [
		// 		{
		// 			"key" : *first_region_id*,
		// 			"doc_count" : *doc_count_for_first_region*,
		// 			"label" : *label_for_first_region*
		// 		},
		// 		... ... ,
		// 		{
		// 			"key" : *last_region_id*,
		// 			"doc_count" : *doc_count_for_last_region*,
		// 			"label" : *label_for_last_region*
		// 		}
		// 	]
		// }

		return results;
	}

// PRIVATE HELPERS
	private struct function _getFilterDsl(
		  string category = ""
		, string region   = ""
	) {

		var filter               = {};
			filter.bool          = {};
			filter.bool.should   = [];
			filter.bool.must     = [];
			filter.bool.must_not = [];

		// either match region or category
		// if ( arguments.region.len() && arguments.category.len() ) {
		// 	filter.bool.should.append( { terms = { region = listToArray('#arguments.region#') } } );
		// 	filter.bool.should.append( { terms = { category = listToArray('#arguments.category#') } } );
		// }

		// if category exists, must exclude selected category
		// if ( arguments.category.len() ) {
		// 	filter.bool.must_not.append( {  terms  = { category  =  listToArray('#arguments.category#') } } );
		// }

		// if category exists, must match selected category
		if ( arguments.category.len() ) {
			filter.bool.must.append( {  terms  = { category  =  listToArray('#arguments.category#') } } );
		}

		// if region exists, must match selected region too on top of previous filter conditions
		if ( arguments.region.len() ) {
			filter.bool.must.append( {  terms  = { region =  listToArray('#arguments.region#') } } );
		}
		// writeDump(filter);abort;
		if( !arrayLen( filter.bool.must_not ) && !arrayLen( filter.bool.must ) && !arrayLen( filter.bool.should ) ){
			filter = {};
		}

		// filter =
		// {
		// 	"bool" : {
		// 		"must"     : [
		// 			{
		// 				"term" : {
		// 					"category" : listToArray(arguments.category)
		// 				}
		// 			},
		// 			{
		// 				"term" : {
		// 					"region" : listToArray(arguments.region)
		// 				}
		// 			}
		// 		],
		// 		"should"   : [],
		// 		"must_not" : []
		// 	}
		// }

		return filter;
	}

	private void function _addAggregationsDsl( required struct dsl ) {

		var aggs = {
			  category = { terms={ field="category" , order={ _term="desc" }, size=50 } }
			, region   = { terms={ field="region"   , order={ _term="desc" }, size=50 } }
		};

		if ( ( dsl.filter ?: {} ).count() ) {
			dsl.aggs = {
				filtered = {
					  filter = dsl.filter
					, aggs   = aggs
				}
			}
		} else {
			dsl.aggs = aggs;
		}

	}

	private void function _translateAggregation( required struct aggregations ) {
		// aggregations =
		// {
		// 	"category" : {
		// 		... ... ,
		// 		... ... ,
		// 		"buckets" : [
		// 			{
		// 				"key" : *first_category_id*,
		// 				"doc_count" : *number_of_documents_with_first_category_id*,
		// 			},
		// 			... ... ,
		// 			{
		// 				"key" : *last_category_id*,
		// 				"doc_count" : *number_of_documents_with_last_category_id*,
		// 			}
		// 		]
		// 	},
		// 	"region" : {
		// 		... ... ,
		// 		... ... ,
		// 		"buckets" : [
		// 			{
		// 				"key" : *first_region_id*,
		// 				"doc_count" : *number_of_documents_with_first_region_id*,
		// 			},
		// 			... ... ,
		// 			{
		// 				"key" : *last_region_id*,
		// 				"doc_count" : *number_of_documents_with_last_region_id*,
		// 			}
		// 		]
		// 	}
		// }
		var filtered = aggregations.filtered ?: aggregations;

		for( var key in filtered ) {
			aggregations[ key ] = filtered[ key ].buckets ?: [];

			if ( aggregations[ key ].len() ) {

				var objectName = "";

				switch( key ) {
					case "category" : objectName="category" ; break;
					case "region"   : objectName="region" ; break;
				}

				if( !isEmpty( objectName ) ){
					for( var i=1; i <= aggregations[ key ].len(); i++ ) {

						var record = $getPresideObject( '#objectName#' ).selectData(
							  selectFields = [ "label", "id" ]
							, id           = aggregations[ key ][i].key
						);

						aggregations[ key ][i].label = record.label ?: "";

					}
				}
			}
		}
	}


// GETTERS AND SETTERS
	private any function _getElasticSearchEngine() {
		return _elasticSearchEngine;
	}
	private void function _setElasticSearchEngine( required any elasticSearchEngine ) {
		_elasticSearchEngine = arguments.elasticSearchEngine;
	}

	private any function _getElasticSearchApi() {
		return _elasticSearchApi;
	}
	private void function _setElasticSearchApi( required any elasticSearchApiWrapper ) {
		_elasticSearchApi = arguments.elasticSearchApiWrapper;
	}

}