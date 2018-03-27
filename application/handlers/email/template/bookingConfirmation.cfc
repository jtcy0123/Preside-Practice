component {
	property name="eventService"        inject="EventService";
	property name="eventBookingService" inject="EventBookingService";

	private struct function prepareParameters( required string bookingId ) {
		var params  = {};
		var args    = {};

		args.bookingDetails = eventBookingService.getBookingDetailsById( arguments.bookingId );

		var eventId = args.bookingDetails.eventId;

		args.eventDetails   = eventService.getEventByID( id=eventId?:"" );

		params.bookingSummary = {
			  html = renderView( view="/email/templates/bookingConfirmation/_summaryHtml", args=args )
			, text = renderView( view="/email/templates/bookingConfirmation/_summaryText", args=args )
		};

		return params;
	}

	private struct function getPreviewParameters() {
		var params  = {};
		var args    = {};

		args.bookingDetails = {
			  bookingLabel    = "Booking 1"
            , firstname       = "John"
            , lastname        = "Doe"
            , num_of_seats    = 3
            , total_amount    = 67.5
            , sessions        = "session1"
            , special_request = ""
		};

		args.eventDetails = {
			  title = "Event 1"
			, start = "2018-01-28 12:00:00"
			, end = "2018-01-28 17:00:00"
		}
		params.bookingSummary = {
			  html = renderView( view="/email/templates/bookingConfirmation/_summaryHtml", args=args )
			, text = renderView( view="/email/templates/bookingConfirmation/_summaryText", args=args )
		};

		return params;
	}

	private string function defaultSubject() {
		return "Your booking confirmation";
	}

	private string function defaultHtmlBody() {
		return renderView( view="/email/templates/bookingConfirmation/defaultHtmlBody" );
	}

	private string function defaultTextBody() {
		return renderView( view="/email/templates/bookingConfirmation/defaultTextBody" );
	}

}