/**
 * @presideService
 */
component {
// CONSTRUCTOR
	/**
	 *
	 */

	public any function init(
	) {
		return this;
	}

// PUBLIC METHODS

	public query function getPrimaryTags( required string pageId ) {

		var tags = $getPresideObject( "our_work" ).selectManyToManyData(
			  propertyName = "tag"
			, id           = arguments.pageId
			, selectFields = [ "tag.id", "tag.slug", "tag.label", "tag.is_primary" ]
			, orderBy      = "sort_order asc"
		);

		return tags;

	}

	public query function getSecondaryTags( required string primaryTag ) {

		var filter       = "post.publishdate IS NOT NULL AND tag.slug IN (:tag.slug)";
		var filterParams = { "tag.slug" = listToArray( arguments.primaryTag ) };

		var postsQuery = $getPresideObject( "post" ).selectData(
			  selectFields        = [ "post.id" ]
			, filter              = filter
			, filterParams        = filterParams
			, getSqlAndParamsOnly = true
		);

		//Some parameters are dynamically set
		for( var param in postsQuery.params  ){
			filterParams[ param.name ] = param;
		}
//		writedump(postsQuery);
//		abort;


		var tags = $getPresideObject( "tag" ).selectData(
			  selectFields = [
				  "tag.id"
				, "tag.slug"
				, "tag.label"
			  ]
			, filter       = "tag.is_primary = false AND postsQuery.id = post_tags.post"
			, filterParams = filterParams
			, groupBy      = "tag.id"
			, extraJoins   = [
				{
					  subQuery          = postsQuery.sql
					, subQueryAlias     = "postsQuery"
					, subQueryColumn    = "id"
					, joinToTable       = "post_tags"
					, joinToColumn      = "post"
					, type              = "left"
				}
			  ]
		);

		return tags;

	}

	public query function getResult(
		  string  primaryTag     = ""
		, string  secondaryTag   = ""
		, numeric maxRows        = 12
		, numeric startRow       = 1
		, boolean getTotalResult = false
	) {

		var selectFields = [
			  "post.id"
			, "post.title"
			, "post.publishdate"
			, "post.image"
			, "post.grid_type"
			, "post.link"
			, "post.show_button"
			, "post.button_text"
		];

		var filter       = "post.publishdate IS NOT NULL";
		var filterParams = {};
		var posts        = queryNew("");
		var tagFilter    = arguments.primaryTag;
		var having       = "";
		var groupBy      = "post.id";
		if ( !isEmpty(arguments.secondaryTag) ) {
			tagFilter = listAppend( tagFilter, arguments.secondaryTag );
		}

		if( !isEmpty(tagFilter) ) {
			filter                   &= " AND tag.slug IN (:tag.slug)";
			filterParams["tag.slug"] = listToArray( tagFilter );
			having                   = "COUNT(DISTINCT tag.id) = #listLen(tagFilter)#";
		}

		if( arguments.getTotalResult ) {
			selectFields       = [ "COUNT( post.id ) as total" ];
			arguments.maxRows  = 999999;
			arguments.startRow = 1;
			if ( isEmpty(arguments.secondaryTag) ) {
				groupBy = "";
			}
		}

		posts = $getPresideObject( "post" ).selectData(
			  selectFields = selectFields
			, orderBy      = "post.publishdate desc"
			, filter       = filter
			, filterParams = filterParams
			, maxRows      = arguments.maxRows
			, startRow     = arguments.startRow
			, groupBy      = groupBy
			, having       = having
		);

		return posts;

	}

// GETTERS AND SETTERS

}