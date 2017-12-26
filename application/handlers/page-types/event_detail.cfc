component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"		 inject="EventService";

	public function relatedEvent( event, rc, prc, args={} ) {
		args.relatedRegionEvent = eventService.getRelatedEvent( id=args.excludeEventId?:"" , region=args.regionIds?:"" );

		return renderView(
			  view = "page-types/event_detail/_relatedEvent"
	    	, args = args
		);
	}
}