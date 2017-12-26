component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"		 inject="EventService";

	public function relatedRegionEvent( event, rc, prc, args={} ) {
		var regionIds = args.regionIds ?: "";

		args.relatedRegionEvent = eventService.getAllEventDetail( id=event.getCurrentPageId(), region=args.regionIds );

		return renderView(
			  view = "page-types/event_detail/_relatedRegionEvent"
	    	, args = args
		);
	}
}