<cfoutput>
	<div class="well">
		<h4>Booking Summary:</h4>
		<table>
			<tr>
				<td style="text-align: right;">Name : </td>
				<td> #args.bookingDetails.firstname# #args.bookingDetails.lastname#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Number of Seats : </td>
				<td> #args.bookingDetails.num_of_seats#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Total Amount : </td>
				<td> RM #numberFormat( #args.bookingDetails.total_amount#,"0.00" )#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Sessions : </td>
				<td> #args.bookingDetails.sessions#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Special Request : </td>
				<td> #args.bookingDetails.special_request#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Event Start Date : </td>
				<td> #datetimeFormat(args.eventDetails.start, "dd mmm yyyy, hh:mm")#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Event End Date : </td>
				<td> #datetimeFormat(args.eventDetails.end, "dd mmm yyyy, hh:mm")#</td>
			</tr>
		</table>
	</div>
</cfoutput>