<cf_presideparam name="args.title"         field="page.title"        editable="true"  />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true"  />
<cf_presideparam name="args.success_message"                         editable="false" />
<cf_presideparam name="args.error_message"                           editable="false" />

<cfset eventId    = args.eventId ?: ""          />
<cfset eventPrice = prc.eventDetail.price ?: "" />
<cfset eventTitle = prc.eventDetail.title ?: "" />

<cfoutput>
	<h1>#args.title#</h1>

	<cfif rc.success?:false>
		<p>#args.success_message#</p>
	<cfelse>
		<cfif rc.error?:false>
			<p>#args.error_message#</p>
		</cfif>

		<p>Event : #eventTitle#</p>
		<p>Price : RM #numberFormat( eventPrice, "0.00" )#/seat</p>

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

	#args.main_content#
</cfoutput>