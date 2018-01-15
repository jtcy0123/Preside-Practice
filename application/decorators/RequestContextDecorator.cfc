component extends="preside.system.coldboxModifications.RequestContextDecorator" {

	public boolean function fullyBooked( required string id ) {
		var eventDetails = getModel( 'EventService' ).getEventByID( id=arguments.id?:"");

		return eventDetails.total_seats == eventDetails.seats_booked;
	}
}