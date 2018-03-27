<cfscript>
	validationResult = rc.validationResult ?: "";
	eventId 		 = args.eventId 	   ?: "";
	totalAmount 	 = args.state.step2Detail.total_amount   ?: "";
</cfscript>

<cfoutput>
	<div class="form-wrap">
		<h4><b>Total Amount : </b>RM #totalAmount#</h4>
		<form action="#event.buildLink( linkTo="page-types.event_booking_page.savePaymentInfo" )#" method="post" class="form form-horizontal">
			<input type="hidden" name="csrfToken" value="#event.getCsrfToken()#"/>
			<input type="hidden" name="eventId"   value="#eventId#"             />

			#renderForm(
				  formName            = prc.newPaymentInfoFormName
				, includeValidationJs = false
				, context             = "website"
				, savedData           = args.details
				, validationResult    = validationResult
			)#

			<div class="form-submit u-aligned-center">
				<input type="submit" value="Submit" class="continue"/>
			</div>
		</form>
	</div>
</cfoutput>