<cfscript>
	savedData        = rc.savedData        ?: {};
	validationResult = rc.validationResult   ?: "";
	eventId 		 = args.eventId 	     ?: "";
	eventPrice 		 = prc.eventDetail.price ?: "";

	event.include("js-booking_session").includeData({ eventPrice=eventPrice })
</cfscript>

<cfoutput>
	<div class="form-wrap">
		<form action="#event.buildLink( linkTo="page-types.event_booking_page.saveSessionDetail" )#" method="post" class="form form-horizontal">
			<input type="hidden" name="csrfToken" value="#event.getCsrfToken()#"/>
			<input type="hidden" name="eventId"   value="#eventId#"             />

			#renderForm(
				  formName            = "event_booking.session_detail"
				, includeValidationJs = false
				, context             = "website"
				, savedData           = args.details
				, validationResult    = validationResult
			)#

			<b>Total Amount : RM <i id="showTotalAmount">#savedData.total_amount?:eventPrice#</i></b>

			<input type="hidden" name="total_amount" />

			<div class="form-submit u-aligned-center show-more right">
				<input type="submit" value="Continue" class="continue"/>
			</div>
		</form>
	</div>
</cfoutput>