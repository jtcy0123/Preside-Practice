/**
 * Expression handler for "User has/has not booked on: {event list}"
 *
 * @feature websiteUsers
 * @expressionContexts user
 * @expressionCategory website_user
 */
component {
	property name="eventBookingService" inject="EventBookingService";
	/**
	 * @ev.fieldType object
	 * @ev.object event_detail
	 */
	private boolean function evaluateExpression(
		  required string  ev
		, 		   boolean _has = true
	) {
		var userId = payload.user.id ?: "";

		if( !len(userId) || !len(ev) ) {
			return !_has;
		}

		var hasBooked = eventBookingService.userHasBookedEvent( userId, ev );

		return hasBooked == _has;
	}

}
