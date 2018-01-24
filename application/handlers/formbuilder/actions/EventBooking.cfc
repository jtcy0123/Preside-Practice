component {
	property name="eventService"        inject="EventService";
	property name="eventBookingService" inject="EventBookingService";
	property name="notificationService" inject="notificationService";

	private void function onSubmit( event, rc, prc, args={} ) {
		var eventId          = rc.evid;

		prc.eventDetail = eventService.getEventByID( id=eventId?:"" )

		var totalAmount = rc.num_of_seats * prc.eventDetail.price ;

		var bookingData = {
			  firstname       = trimHtml( rc.firstname?:"" )
			, lastname        = trimHtml( rc.lastname?:"" )
			, email           = trimHtml( rc.email )
			, num_of_seats    = rc.num_of_seats?:0
			, session         = rc.sessions
			, special_request = trimHtml( rc.special_request )
			, total_amount    = totalAmount
			, event_detail    = eventId
		}

		var results     = eventBookingService.saveBooking( argumentCollection = bookingData );

		if ( len(results) ) {
			notificationService.createNotification(
				  topic = "newBooking"
				, type  = "INFO"
				, data  = bookingData
			);
		}
	}
}