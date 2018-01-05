<cf_presideparam name="args.title"         field="page.title"        editable="true"  />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true"  />
<cf_presideparam name="args.success_message"                         editable="false" />
<cf_presideparam name="args.error_message"                           editable="false" />

<cfset eventId    = args.eventId ?: ""          />
<cfset eventPrice = prc.eventDetail.price ?: "" />
<cfset eventTitle = prc.eventDetail.title ?: "" />

<!--- <cfdump var="#rc#" > --->

<cfoutput>
	<h1>#args.title#</h1>

<!--- 	<cfif rc.success?:false>
		<p>#args.success_message#</p>
	<cfelse> --->
		<cfif rc.error?:false>
			<p>#args.error_message#</p>
		</cfif>
		<cfif len(rc.evid?:"")?:false>
			<p>Event : #eventTitle#</p>
			<p>Price : RM #numberFormat( eventPrice, "0.00" )#/seat</p>

			<cfswitch expression="#args.currentStep#">
				<cfcase value="2">
					#renderView( view='page-types/event_booking_page/_sessionDetail', args=args )#
				</cfcase>
				<cfcase value="3">
					#renderView( view='page-types/event_booking_page/_paymentInfo', args=args )#
				</cfcase>
				<cfdefaultcase>
					#renderView( view='page-types/event_booking_page/_personalDetail', args=args )#
				</cfdefaultcase>
			</cfswitch>
<!---
			<cfif event.fullyBooked( eventId ) >
				<p>Seats sold out for this event.</p>
			<cfelse>
				<form id="booking-form" action="#event.buildLink(linkTo="page-types.event_booking_page.createBooking")#" class="form form-horizontal" method="POST">

					#renderForm(
						  formName         = "event_booking.booking_info"
						, context          = "website"
						, formId           = "booking-form"
						, validationResult = rc.validationResult ?: ""
						, savedData        = rc.formData ?: {}
					)#

					<input type="hidden" name="eventId"    value="#eventId#"    />
					<input type="submit"                   value="Submit"       />
				</form>
			</cfif>
 --->
		<cfelse>
			<p><a href="/event.html">Back to events page</a></p>
		</cfif>
	<!--- </cfif> --->

	#args.main_content#
</cfoutput>