component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"		 inject="EventService";

	public function index( event, rc, prc, args={} ){
		prc.eventDetail = eventService.getAllEventDetail( parentPage = event.getCurrentPageId(), region = rc.region?:"", category = rc.category?:"" )

		prc.category    = presideObjectService.selectData(
							objectName="category"
						);

		prc.region      = presideObjectService.selectData(
							objectName="region"
						);

		return  renderView(
		      view          = "page-types/event_listing/index"
		    , presideObject = "event_listing"
		    , id            = event.getCurrentPageId()
		    , args 			= args
		);
	}

	public function featuredEvent( event, rc, prc, args={} ) {
		var eventIds = args.eventIds ?: "";

		args.featuredEvent = eventService.getAllEventDetail( parentPage = event.getCurrentPageId(), id=args.eventIds );

		return renderView(
			  view          = "page-types/event_listing/_featuredEvent"
	    	, args 			= args
		);
	}
}