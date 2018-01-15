<cfoutput>
Booking Summary
Name            : #args.bookingDetails.firstname# #args.bookingDetails.lastname#
Number of Seats : #args.bookingDetails.num_of_seats#
Total Amount    : RM #numberFormat( args.bookingDetails.total_amount, "0.00" )#
Sessions    	: #args.bookingDetails.sessions#
Special Request : #args.bookingDetails.special_request#
Event Starts    : #datetimeFormat(args.eventDetails.start, "dd mmm yyyy, hh:mm")#
Event Ends      : #datetimeFormat(args.eventDetails.end, "dd mmm yyyy, hh:mm")#
</cfoutput>