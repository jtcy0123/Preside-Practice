<cfparam name="args.firstname"       type="string"  default="" />
<cfparam name="args.lastname"        type="string"  default="" />
<cfparam name="args.email"           type="string"  default="" />
<cfparam name="args.num_of_seats"    type="numeric" default="" />
<cfparam name="args.session"        type="string"  default="" />
<cfparam name="args.special_request" type="string"  default="" />
<cfparam name="args.total_amount"    type="numeric" default="" />

<cfoutput>
	<div class="well">
		<h4>Booking Summary:</h4>
		<table>
			<tr>
				<td style="text-align: right;">Event : </td>
				<td> #args.eventDetails.title#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Name : </td>
				<td> #args.firstname# #args.lastname#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Number of Seats : </td>
				<td> #args.num_of_seats#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Total Amount : </td>
				<td> RM #numberFormat( #args.total_amount#,"0.00" )#</td>
			</tr>
			<tr>
				<td style="text-align: right;">Sessions : </td>
				<td>
					<cfloop list="#args.session#" item="ses">
						#renderLabel( "session" , ses )# <cfif ses neq listLast(args.session)>,</cfif>
					</cfloop>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">Special Request : </td>
				<td> #args.special_request#</td>
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