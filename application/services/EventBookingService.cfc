/**
* @presideService
*/
component {
	/**
	* @workflowService.inject workflowService
	* @siteTreeService.inject siteTreeService
	*/

	public function init(
		  required any siteTreeService
		, required any workflowService
	) {
		_setSiteTreeService( arguments.siteTreeService );
		_setWorkflowService( arguments.workflowService );

		return this;
	}

	public function getBookingDetailsById( string bookingId="" ) {
		if ( !len(arguments.bookingId) ) {
			return QueryNew("");
		}

		return $getPresideObjectService().selectData(
			  objectName   = "event_booking"
			, selectFields = [
				  "event_booking.firstname"
				, "event_booking.lastname"
				, "event_booking.email"
				, "event_booking.num_of_seats"
				, "event_booking.total_amount"
				, "GROUP_CONCAT(sessions.label) as sessions"
				, "event_booking.special_request"
				, "event_detail$page.id as eventId"
			]
			, filter       = { "event_booking.id" = arguments.bookingId }
			, groupBy      = "event_booking.id"
		);
	}

	public struct function getApplicationProgress( string eventId="" ) {
		var workflowArgs = {
			  workflow  = "eventBooking"
			, reference = arguments.eventId
		};
		return _getWorkflowService().getState( argumentCollection = workflowArgs );
	}

	public void function updateApplicationProgress( string eventId="", required string step, struct stateDetail={} ) {
		var workflowArgs = {
			  workflow  = "eventBooking"
			, reference = arguments.eventId
			, state     = arguments.stateDetail
			, status    = arguments.step
			, expires   = _getApplicationWorkflowExpiry()
		};

		_getWorkflowService().appendToState( argumentCollection = workflowArgs );
	}

	private date function _getApplicationWorkflowExpiry() {
		return DateAdd( "d", 1, now() );
	}

	public struct function finalizeApplication( string eventId="" ) {
		var result              = { success = true };
		var applicationProgress = getApplicationProgress( arguments.eventId );
		var applicationState    = applicationProgress.state ?: {};

		var bookingData = {
			  id              = applicationProgress.id                       ?: ""
			, firstname       = applicationState.step1Detail.firstname       ?: ""
            , lastname        = applicationState.step1Detail.lastname        ?: ""
            , email           = applicationState.step1Detail.email           ?: ""
            , num_of_seats    = applicationState.step2Detail.num_of_seats    ?: ""
            , sessions        = applicationState.step2Detail.session         ?: ""
            , special_request = applicationState.step2Detail.special_request ?: ""
            , total_amount    = applicationState.step2Detail.total_amount    ?: ""
            , purchaseNum     = applicationState.step3Detail.purchaseNum     ?: ""
            , creditCardNum   = applicationState.step3Detail.creditCardNum   ?: ""
            , expiredDate     = applicationState.step3Detail.expiredDate     ?: ""
            , event_detail    = applicationState.step3Detail.event_detail    ?: ""
		}

		bookingData.label = bookingData.firstname & " - " & datetimeFormat(now(), "dd mmm yyyy HH:mm:ss");

		var newBooking   = "";
		var seatsDetails = $getPresideObjectService().selectData(
			  objectName   = "event_detail"
			, selectFields = [ "total_seats", "seats_booked" ]
			, filter       = { "id"=bookingData.event_detail }
		);

		if ( !len(seatsDetails.seats_booked) ) {
			seatsDetails.seats_booked = 0;
		}

		if ( len(seatsDetails.total_seats) && len(seatsDetails.seats_booked) && ( seatsDetails.total_seats GTE seatsDetails.seats_booked + bookingData.num_of_seats ) ) {
			try {
				newBooking   = $getPresideObjectService().insertData(
					  objectName              = "event_booking"
					, data                    = bookingData
					, insertManyToManyRecords = true
				);

				_siteTreeService.editPage(
					  id           = bookingData.event_detail
					, seats_booked = val( seatsDetails.seats_booked + bookingData.num_of_seats )
				);

				if ( len(newBooking) ) {
					$sendEmail(
						  template = "bookingConfirmation"
						, to       = [ bookingData.email ]
						, args     = { bookingId = newBooking }
					);

					$createNotification(
						  topic = "newBooking"
						, type  = "INFO"
						, data  = bookingData
					);
				}

				_getWorkflowService().complete( id=applicationProgress.id );
			}
			catch(e) {
				$raiseError(e);
	            result.statusCode        = "FAILED";
	            result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
	            result.success           = false;
			}
		}

		return result;
	}


	public function saveBooking(
		  required string  firstname
        , required string  lastname
        , required string  email
        , required numeric num_of_seats
        , required string  session
        ,                  special_request
        , required numeric total_amount
        , required string  event_detail
	) {
		var bookingLabel = arguments.firstname & " - " & datetimeFormat(now(), "dd mmm yyyy HH:mm:ss");
		var bookingData  = {
			  label           = bookingLabel
			, firstname       = arguments.firstname
            , lastname        = arguments.lastname
            , email           = arguments.email
            , num_of_seats    = arguments.num_of_seats
            , sessions        = arguments.session
            , special_request = arguments.special_request
            , total_amount    = arguments.total_amount
            , event_detail    = arguments.event_detail
		};
		var newBooking   = "";
		var seatsDetails = $getPresideObjectService().selectData(
			objectName = "event_detail"
			, selectFields = [ "total_seats", "seats_booked" ]
			, filter       = { "id"=arguments.event_detail }
		);

		if ( !len(seatsDetails.seats_booked) ) {
			seatsDetails.seats_booked = 0;
		}

		if ( len(seatsDetails.total_seats) && len(seatsDetails.seats_booked) && ( seatsDetails.total_seats GTE seatsDetails.seats_booked + arguments.num_of_seats ) ) {
			newBooking   = $getPresideObjectService().insertData(
				  objectName              = "event_booking"
				, data                    = bookingData
				, insertManyToManyRecords = true
			);

			_siteTreeService.editPage(
				  id           = arguments.event_detail
				, seats_booked = val( seatsDetails.seats_booked + arguments.num_of_seats )
			);

			$sendEmail(
				  template = "bookingConfirmation"
				, to       = [ arguments.email ]
				, args     = { bookingId = newBooking }
			);
		}

		return newBooking;
	}


	// getters and setters
	private any function _getSiteTreeService() {
		return _siteTreeService;
	}

	private void function _setSiteTreeService( required any siteTreeService ) {
		_siteTreeService = arguments.siteTreeService;
	}

	private any function _getWorkflowService() {
		return _workflowService;
	}

	private void function _setWorkflowService( required any workflowService ) {
		_workflowService = arguments.workflowService;
	}
}