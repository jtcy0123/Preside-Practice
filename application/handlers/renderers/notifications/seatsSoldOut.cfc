component {
	property name="eventService" inject="EventService";

	private string function datatable( event, rc, prc, args={} ) {
		var eventName = eventService.getEventByID( id=args.evId?:"" ).title;

		return "Seats sold out for event " & htmlEditFormat(eventName);
	}

	private string function full( event, rc, prc, args={} ) {
        return renderView(
              view = "/renderers/notifications/seatsSoldOut/full"
            , args = args
        );
    }

}