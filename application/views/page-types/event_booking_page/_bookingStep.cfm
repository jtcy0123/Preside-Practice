<cfscript>
	param name="args.step"         type="string";
	param name="args.title"        type="string";
	param name="args.currentStep"  type="string";

	isComplete = args.step < args.currentStep;
	isCurrent  = args.step == args.currentStep;
	isLast     = args.currentStep == 6;

	class = isComplete ? " done" : ( isCurrent ? " active" : "" );
	class &= isLast ? " last" : "";

	eventId = args.eventId ?: "";
</cfscript>

<cfoutput>
	<li class="step#class#">
		<cfif isComplete>
			<a href="#event.buildlink( linkto="page-types.event_booking_page.prevStep", queryString="evid=#eventId#&step=#args.step#" )#" class="continue pull-right">Edit</a>
		</cfif>
		<h2 class="step-heading">
			#args.title#
		</h2>

		<cfif isCurrent>
			<div class="step-content">
				#renderViewlet( event = "page-types.event_booking_page.bookingStep", args = args )#
			</div>
		</cfif>
	</li>
</cfoutput>