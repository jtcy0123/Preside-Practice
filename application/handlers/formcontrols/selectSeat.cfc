component {

	property name="presideObjectService" inject="presideObjectService";

	private function website( event, rc, prc, args={} ) {

		var seatsDetails = presideObjectService.selectData(
			  objectName   = args.object
			, selectFields = [ "total_seats", "seats_booked" ]
			, filter       = { "id"=rc.evid }
		);

		if ( !len( seatsDetails.seats_booked ) ){
			seatsDetails.seats_booked = 0;
		}
		if ( len( seatsDetails.total_seats ) ){
			args.seatsAvailable = seatsDetails.total_seats - seatsDetails.seats_booked;
		}

		return renderView(
			  view = 'formcontrols/selectSeat/website'
			, args = args
		);
	}
}