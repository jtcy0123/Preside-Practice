<cfscript>
	savedData        = rc.savedData          ?: {};
	validationResult = rc.validationResult   ?: "";
	eventId 		 = args.eventId 	     ?: "";
	eventPrice 		 = prc.eventDetail.price ?: "";
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
				, savedData           = savedData
				, validationResult    = validationResult
			)#

			<b>Total Amount : <i id="showTotalAmount">RM #savedData.total_amount?:""#</i></b>
			<script>
				var seats = document.getElementById('num_of_seats');
				seats.onchange = calculateAmount;
				function calculateAmount(){
					var price = this.value * #eventPrice#;
					price = price.toFixed(2);
					document.getElementById("showTotalAmount").innerHTML = price;
				}
			</script>

			<input type="hidden" name="total_amount" />

			<div class="form-submit u-aligned-center">
				<a href="#event.buildlink( linkto="page-types.event_booking_page.prevStep", queryString="evid=#eventId#&step=1" )#" class="pull-left">Back</a>

				<input type="submit" value="Submit" class="btn btn-default"/>
			</div>
		</form>
	</div>
</cfoutput>