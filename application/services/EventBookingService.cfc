/**
* @presideService
*/
component {

	public function init() {}

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
		var bookingLabel = arguments.firstname & " - " & datetimeFormat(now(), "dd mmm yyyy HH:mm:ss")
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
		}
		var newBooking   = "";
		newBooking = $getPresideObjectService().insertData(
			  objectName              = "event_booking"
			, data                    = bookingData
			, insertManyToManyRecords = true
		);

		$sendEmail(
			  template = "bookingConfirmation"
			, to       = [ arguments.email ]
			, args     = { bookingId = newBooking }
		);

		return newBooking;
	}

}