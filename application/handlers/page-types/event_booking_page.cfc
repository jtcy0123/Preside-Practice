component {
	property name="formsService"        inject="formsService";
	property name="eventService"        inject="EventService";
	property name="notificationService" inject="notificationService";
	property name="eventBookingService" inject="EventBookingService";

	private function index( event, rc, prc, args={} ) {

		args.eventId = rc.evid ?: "";
		prc.eventDetail = eventService.getEventByID( id=args.eventId?:"" );

		if( rc.success ?: false ) {
			return renderView(
				  view          = 'page-types/event_booking_page/success'
				, presideObject = 'event_booking_page'
				, id            = event.getCurrentPageId()
				, args          = args
			);
		}

		var applicationProgress = eventBookingService.getApplicationProgress( eventId = args.eventId );
		args.currentStep = isNumeric( applicationProgress.status?:"" ) && applicationProgress.status <= 3 ? applicationProgress.status : 1;
		args.state = applicationProgress.state?:"";

		rc.savedData = rc.savedData ?: applicationProgress.state['step#args.currentStep#Detail'] ?: {};

		return renderView(
			  view          = 'page-types/event_booking_page/index'
			, presideObject = 'event_booking_page'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function savePersonalDetail( event, rc, prc, args={} ) {
		var formName         = 'event_booking.personal_detail';
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		var eventId          = rc.eventId;

		if ( validationResult.validated() ) {
			eventBookingService.updateApplicationProgress(
				  eventId     = eventId
				, step        = 2
				, stateDetail = { step1Detail = formData }
			);
			setNextEvent( url=event.buildlink( page="event_booking_page", querystring="evid="&eventId ) );
		}

		setNextEvent(
			  url           = event.buildlink( page="event_booking_page", querystring="evid="&eventId )
			, persistStruct = {
				  validationResult = validationResult
				, savedData		   = formData
				, error            = true
			}
		);
	}

	public function saveSessionDetail( event, rc, prc, args={} ) {
		var formName         = 'event_booking.session_detail';
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		var eventId          = rc.eventId;

		prc.eventDetail = eventService.getEventByID( id=eventId?:"" )

		formData.total_amount = formData.num_of_seats * prc.eventDetail.price ;

		if ( validationResult.validated() ) {
			eventBookingService.updateApplicationProgress(
				  eventId     = eventId
				, step        = 3
				, stateDetail = { step2Detail = formData }
			);
			setNextEvent( url=event.buildlink( page="event_booking_page", querystring="evid="&eventId ) );
		}

		setNextEvent(
			  url           = event.buildlink( page="event_booking_page", querystring="evid="&eventId )
			, persistStruct = {
				  validationResult = validationResult
				, savedData		   = formData
				, error            = true
			}
		);
	}

	public function savePaymentInfo( event, rc, prc, args={} ) {
		var formName         = 'event_booking.payment_info';
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		var eventId          = rc.eventId;

		formData.event_detail = eventId;

		if ( validationResult.validated() ) {
			eventBookingService.updateApplicationProgress(
				  eventId     = eventId
				, step        = 3
				, stateDetail = { step3Detail = formData }
			);

			var result = eventBookingService.finalizeApplication( eventId=eventId );

			setNextEvent(
				  url           = event.buildlink( page="event_booking_page", querystring="evid="&eventId )
				, persistStruct = { success = true }
			);
		}

		setNextEvent(
			  url           = event.buildlink( page="event_booking_page", querystring="evid="&eventId )
			, persistStruct = {
				  validationResult = validationResult
				, savedData		   = formData
				, error            = true
			}
		);
	}

	public void function prevStep( event, rc, prc ) {
		var eventId = rc.evid;

		rc.step = isNumeric( rc.step?:"" ) && rc.step <= 2 ? rc.step : 1;
		eventBookingService.updateApplicationProgress( eventId = eventId, step = rc.step );

		setNextEvent( url =  event.buildlink( page="event_booking_page", querystring="evid="&eventId ) );
	}

/*
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
*/
}
