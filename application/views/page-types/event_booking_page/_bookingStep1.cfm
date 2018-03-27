<cfscript>
	validationResult = rc.validationResult ?: "";
	eventId 		 = args.eventId 	   ?: "";
</cfscript>

<cfoutput>
	<div class="form-wrap">
		<form action="#event.buildLink( linkTo="page-types.event_booking_page.savePersonalDetail" )#" method="post" class="form form-horizontal">
			<input type="hidden" name="csrfToken" value="#event.getCsrfToken()#"/>
			<input type="hidden" name="eventId"   value="#eventId#"             />

			#renderForm(
				  formName            = "event_booking.personal_detail"
				, includeValidationJs = false
				, context             = "website"
				, savedData           = args.details
				, validationResult    = validationResult
			)#

			<div class="form-submit u-aligned-center show-more right">
				<input type="submit" value="Continue" class="continue"/>
			</div>
		</form>
	</div>
</cfoutput>