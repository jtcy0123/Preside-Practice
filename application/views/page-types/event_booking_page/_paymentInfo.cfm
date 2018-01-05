<cfscript>
	savedData        = rc.savedData        ?: {};
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
				  formName            = "event_booking.payment_info"
				, includeValidationJs = false
				, context             = "website"
				, savedData           = savedData
				, validationResult    = validationResult
			)#

			<div class="form-submit u-aligned-center">
				<a href="#event.buildlink( linkto="page-types.event_booking_page.prevStep", queryString="evid=#eventId#&step=2" )#" class="pull-left">Back</a>

				<input type="submit" value="Submit" class="btn btn-default"/>
			</div>
		</form>
	</div>
</cfoutput>