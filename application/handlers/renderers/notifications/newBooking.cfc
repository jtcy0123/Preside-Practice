component {
	property name="eventService" inject="EventService";
	property name="eventBookingService" inject="EventBookingService";

	private string function datatable( event, rc, prc, args={} ) {
        var customerName = args.firstname & " " & args.lastname;

        return "New booking made by: " & HtmlEditFormat( customerName );
    }

    private string function full( event, rc, prc, args={} ) {
        args.eventDetails = eventService.getEventByID( id=args.event_detail?:"" );

        args.booking = eventBookingService.getBookingDetailsById(bookingId="CD16A9DB-694D-4A4E-BA0EEC449F15EEE8");

        return renderView(
              view = "/renderers/notifications/newBooking/full"
            , args = args
        );
    }

    private string function emailSubject( event, rc, prc, args={} ) {
        return "New Booking";
    }

    private string function emailHtml( event, rc, prc, args={} ) {
        var data = deserializeJSON(args.data)

        prc.eventDetails = eventService.getEventByID( id=args.event_detail?:"" );

        return renderView(
              view = "/renderers/notifications/newBooking/emailHtml"
            , args = data
        );
    }

    private string function emailText( event, rc, prc, args={} ) {
        var data = deserializeJSON(args.data)

        prc.eventDetails = eventService.getEventByID( id=args.event_detail?:"" );

        return renderView(
              view = "/renderers/notifications/newBooking/emailText"
            , args = data
        );
    }
}