<cfoutput>
Booking Summary
Name            : #args.firstname?:""# #args.lastname?:""#
Number of Seats : #args.num_of_seats?:""#
Total Amount    : RM #numberFormat( args.total_amount?:"", "0.00" )#
Sessions    	:
<cfloop list="#args.session?:""#" item="ses">
	#renderLabel( "session" , ses )# <cfif ses neq listLast(args.session)>,</cfif>
</cfloop>
Special Request : #args.special_request?:""#
Event Starts    : #datetimeFormat(args.start?:"", "dd mmm yyyy, hh:mm")#
Event Ends      : #datetimeFormat(args.end?:"", "dd mmm yyyy, hh:mm")#
</cfoutput>