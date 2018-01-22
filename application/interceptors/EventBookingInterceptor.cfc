component extends="coldbox.system.Interceptor" {

	property name="presideObjectService" inject="provider:PresideObjectService";
	property name="notificationService"  inject="provider:notificationService";
	property name="eventService"  inject="provider:EventService";

	public void function postUpdateObjectData( required any event, required struct interceptData ) {
		var objectName   = arguments.interceptData.objectName ?: "";
		var id           = arguments.interceptData.id         ?: "";
		var data         = arguments.interceptData.data;

		switch( objectName ){
			case "event_detail":

				var eventDetails = eventService.getEventByID( id=data.id?:"" );

				if ( structKeyExists( eventDetails, "total_seats" ) && structKeyExists( data, "seats_booked" ) && val(eventDetails.total_seats) == data.seats_booked ) {
					notificationService.createNotification(
						  topic = "seatsSoldOut"
						, type = "Info"
						, data = {
							  evId       = data.id
							, eventTitle = eventDetails.title
							, totalSeats = eventDetails.total_seats
						}
					);
				}
			break;
		}
	}
}
