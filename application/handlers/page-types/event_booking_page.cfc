component {
	property name="formsService"        inject="formsService";
	property name="eventService"        inject="EventService";
	property name="eventBookingService" inject="EventBookingService";
	property name="notificationService" inject="notificationService";

	private function index( event, rc, prc, args={} ) {

		args.eventId = rc.evid ?: "";

		prc.eventDetail = eventService.getEventByID( id=args.eventId?:"" )

		return renderView(
			  view          = 'page-types/event_booking_page/index'
			, presideObject = 'event_booking_page'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function createBooking( event, rc, prc, args={} ) {
		var bookingFormName  = "event_booking.booking_info";
		var bookingFormData  = event.getCollectionForForm( bookingFormName );
		var validationResult = validateForm( bookingFormName, bookingFormData );
		var eventId          = rc.eventId;

		if ( !validationResult.validated() ) {
			var persist              = bookingFormData;
			persist.validationResult = validationResult;
			persist.error            = true;

			setNextEvent(
				  url           = event.buildLink( page="event_booking_page", querystring="evid="&eventId )
				, persistStruct = persist
			);
		} else {
			prc.eventDetail = eventService.getEventByID( id=eventId?:"" )

			var totalAmount = bookingFormData.num_of_seats * prc.eventDetail.price ;

			var bookingData = {
				  firstname       = trimHtml( bookingFormData.firstname )
				, lastname        = trimHtml( bookingFormData.lastname )
				, email           = trimHtml( bookingFormData.email )
				, num_of_seats    = bookingFormData.num_of_seats
				, session         = bookingFormData.session
				, special_request = trimHtml( bookingFormData.special_request )
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

			setNextEvent(
				  url           = event.buildLink(page="event_booking_page")
				, persistStruct = { success = true }
			 )
		};

	}
}
