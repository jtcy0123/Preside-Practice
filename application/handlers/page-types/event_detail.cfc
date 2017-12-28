component {

	property name="presideObjectService" inject="PresideObjectService";
	property name="eventService"		 inject="EventService";

	public function relatedEvent( event, rc, prc, args={} ) {
		args.relatedRegionEvent = eventService.getRelatedEvent( excludeId=args.excludeEventId?:"" , region=args.regionIds?:"", numOfEvent=args.numEventToShow?:"5" );

		return renderView(
			  view = "page-types/event_detail/_relatedEvent"
	    	, args = args
		);
	}

	public function expiredEvent( event, rc, prc, args={} ) {
		args.expiredEvent = eventService.getExpiredEvent();

		return renderView(
			  view = "page-types/event_detail/_expiredEvent"
	    	, args = args
		);
	}
}