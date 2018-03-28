component {

	property name="ourWorkService" inject="OurWorkService";

/**
 * @cacheable true
 */
	private function index( event, rc, prc, args={} ) {
		var pageId         = event.getCurrentPageId();
		args.primaryTag    = rc.primaryTag   ?: "";
		args.primaryTag    = (args.primaryTag == "all-work") ? "" : args.primaryTag;
		args.secondaryTag  = rc.secondaryTag ?: "";
		args.subFilterHtml = "";

		args.maxRows       = 12;
		args.tags          = ourWorkService.getPrimaryTags( pageId=pageId);
		args.results       = ourWorkService.getResult(
			  primaryTag   = args.primaryTag
			, secondaryTag = args.secondaryTag
			, maxRows      = args.maxRows
		);
		args.resultsTotal  = ourWorkService.getResult(
			  primaryTag     = args.primaryTag
			, secondaryTag   = args.secondaryTag
			, getTotalResult = true
		).total;
		args.hasMoreResult = args.resultsTotal GT args.maxRows;

		if( !isEmpty( args.primaryTag ) ) {
			args.subFilterHtml = _getSecondaryTags( args.primaryTag );
		}

		return renderView(
			  view          = 'page-types/our_work/index'
			, presideObject = 'our_work'
			, id            = pageId
			, args          = args
		);

	}

	public function applyNewFilter( event, rc, prc, args={} ) {
		var primaryTag    = rc.primary_tag   ?: "";
		var secondaryTag  = rc.secondary_tag ?: "";
		var subFilterHtml = "";

		args.maxRows = rc.maxRows       ?: 12;
		primaryTag   = (primaryTag == "all-work") ? "" : primaryTag;

		if( rc.fetchSecondaryFilter ?: false ) {
			subFilterHtml = _getSecondaryTags( primaryTag )
		}

		args.results = ourWorkService.getResult(
			  primaryTag   = primaryTag
			, secondaryTag = secondaryTag
			, maxRows      = args.maxRows
		);

		var resultsTotal = ourWorkService.getResult(
			  primaryTag     = primaryTag
			, secondaryTag   = secondaryTag
			, getTotalResult = true
		).total;

		event.renderData(
			  data = {
			  	  results_total = resultsTotal
				, results       = renderView( view='page-types/our_work/_result' , args=args )
				, subFilter     = subFilterHtml
			}
			, type = "json"
		);

	}

	public function loadMore( event, rc, prc, args={} ) {

		var primaryTag   = rc.primary_tag   ?: "";
		var secondaryTag = rc.secondary_tag ?: "";
		var page         = rc.page          ?: 2;
		var startRow     = page * maxRows;
		args.maxRows     = rc.maxRows       ?: 12;
		primaryTag       = (primaryTag == "all-work") ? "" : primaryTag;

		args.results = ourWorkService.getResult(
			  primaryTag   = primaryTag
			, secondaryTag = secondaryTag
			, maxRows      = args.maxRows
			, startRow     = startRow
		);

		return renderView(
			  view = 'page-types/our_work/_result'
			, args = args
		);

	}

	private function _getSecondaryTags( string primaryTag="" ) {

		var primaryTag = arguments.primaryTag ?: "";
			primaryTag = (primaryTag == "all-work") ? "" : primaryTag;

		args.secondaryTags = ourWorkService.getSecondaryTags( primaryTag=primaryTag );

		return renderView(
		  view = 'page-types/our_work/_secondaryFilter'
			, args = args
		);

	}

}
