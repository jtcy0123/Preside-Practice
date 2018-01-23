component {
	property name="resourceLibrarySearchEngine" inject="ResourceLibrarySearchEngine";
	property name="presideObjectService" inject="PresideObjectService";

	public function index( event, rc, prc, args={} ) {
		rc.category = rc.category?:"";
		rc.region = rc.region?:"";

		prc.results = _getSearchResult( argumentCollection = arguments );

		if ( event.isAjax() ) {
			return renderView( view="page-types/resource_library_page/_results" );
		}

		return renderView(
			  view          = 'page-types/resource_library_page/index'
			, presideObject = 'resource_library_page'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	private function _getSearchResult( event, rc, prc, args={} ) {

		rc.pageId    = rc.pageId   ?: "";
		rc.maxRows   = rc.maxRows  ?: "";
		rc.category  = rc.category ?: "";
		rc.region    = rc.region  ?: "";

		args.maxRows  = args.maxRows  ?: rc.maxRows;
		args.pageId   = args.pageId   ?: rc.pageId;
		args.category = args.category ?: rc.category;
		args.region   = args.region  ?: rc.region;

		var pageSize = isNumeric( args.maxRows  ) && args.maxRows <= 999999 ? args.maxRows : 2;
		var page     = isNumeric( rc.page ?: "" ) && rc.page      <= 999999 ? rc.page      : 1;

		if( isEmpty( args.category ) || isEmpty( args.region ) ){
			var defaultFilterValues = presideObjectService.selectData(
				  objectName   = "resource_library_page"
				, selectFields = [
					  "group_concat( distinct category.id ) as category"
					, "group_concat( distinct region.id ) as region"
				]
				, id           = args.pageId
			)

			if( isEmpty( args.category ) ){
				args.category = defaultFilterValues.category;
			}

			if( isEmpty( args.region ) ){
				args.region = defaultFilterValues.region;
			}
		}

		return resourceLibrarySearchEngine.search(
			  category = args.category
			, region   = args.region
			, page     = page
			, pageSize = pageSize
		);
	}

}