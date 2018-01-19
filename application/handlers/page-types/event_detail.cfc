component {

	property name="presideObjectService"        inject="PresideObjectService";
	property name="eventService"		        inject="EventService";
	property name="rulesEngineConditionService" inject="RulesEngineConditionService";

	public function index( event, rc, prc, args={} ) {
		var conditionId = prc.presidePage.condition;


		prc.eventDetail = eventService.getEventById( id=prc.presidePage.id?:"" );

		prc.condition   = rulesEngineConditionService.evaluateCondition(
				  conditionId = conditionId
				, context = "user"
			);

		if ( !isLoggedIn() ) {
			event.accessDenied( reason="LOGIN_REQUIRED" );
		} else if ( !prc.condition ) {
			event.accessDenied( reason="INSUFFICIENT_PRIVILEGES" );
		}

		return renderView(
			  view = "page-types/event_detail/detail"
			, args = args
		);
	}

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