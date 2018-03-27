component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"		 inject="EventService";
	property name="multilingualPresideObjectService" inject="multilingualPresideObjectService";

	public function index( event, rc, prc, args={} ){
		prc.events = eventService.getAllEventDetail( parentPage = event.getCurrentPageId()?:"", region = rc.region?:"", category = rc.category?:"" );

		rc.maxPerPage = 2;
		rc.page = rc.page?:1;
		rc.totalPage = ROUND(prc.events.recordCount / rc.maxPerPage);

		prc.eventDetail = eventService.getAllEventDetail( parentPage = event.getCurrentPageId()?:"", region = rc.region?:"", category = rc.category?:"", currentPage=rc.page, maxRows=rc.maxPerPage );

		prc.category    = presideObjectService.selectData(
							objectName="category"
						);

		prc.region      = presideObjectService.selectData(
							objectName="region"
						);

		prc.availableLanguages = multilingualPresideObjectService.listLanguages();

		if( event.isAjax() ) {
			event.noLayout();

			return  renderView(
			      view = "page-types/event_listing/_eventDetail2"
			    , args = args
			);
		}

		return  renderView(
		      view          = "page-types/event_listing/index"
		    , presideObject = "event_listing"
		    , id            = event.getCurrentPageId()
		    , args 			= args
		);
	}

	public function featuredEvent( event, rc, prc, args={} ) {
		var eventIds = args.eventIds ?: "";

		args.featuredEvent = eventService.getEventByID( id=args.eventIds?:"" );

		return renderView(
			  view          = "page-types/event_listing/_featuredEvent"
	    	, args 			= args
		);
	}
}