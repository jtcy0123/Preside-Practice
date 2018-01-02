<cf_presideparam name="args.eventtitle" field="page.title" />
<cf_presideparam name="args.startdate"                     />
<cf_presideparam name="args.enddate"                       />

<cfoutput>
	<li>
		<strong>#eventDetail.title#</strong> from #dateFormat(eventDetail.startdate, "dd mmm yyyy")# #timeFormat(eventDetail.startdate, "HH:mm")# to #dateFormat(eventDetail.enddate, "dd mmm yyyy")# #timeFormat(eventDetail.enddate, "HH:mm")#
	</li>
</cfoutput>