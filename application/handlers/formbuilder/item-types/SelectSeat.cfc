component {
	property name="presideObjectService" inject="presideObjectService";

	private string function renderInput( event, rc, prc, args={} ) {

		if ( len(rc.evid?:"") ) {
			var seatsDetails = presideObjectService.selectData(
				  objectName   = "event_detail"
				, selectFields = [ "total_seats", "seats_booked" ]
				, filter       = { "id"=rc.evid }
			);

			if ( !len( seatsDetails.seats_booked ) ){
				seatsDetails.seats_booked = 0;
			}
			if ( len( seatsDetails.total_seats ) ){
				args.seatsAvailable = seatsDetails.total_seats - seatsDetails.seats_booked;
			}
		}

		var controlName = args.name ?: "";

		return renderFormControl(
			  argumentCollection = args
			, name               = controlName
			, type               = "selectSeat"
			, context            = "formbuilder"
			, id                 = args.id ?: controlName
			, layout             = ""
			, required           = IsTrue( args.mandatory ?: "" )
		);
	}
}