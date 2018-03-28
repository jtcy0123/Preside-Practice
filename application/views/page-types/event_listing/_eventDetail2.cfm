<cfset eventDetail = prc.eventDetail?:QueryNew("")>

<cfoutput>
	<cfloop query="eventDetail">
		<li>
			<a href="#event.buildLink(page=eventDetail.id)#">
				<strong>#eventDetail.title#</strong> from #dateFormat(eventDetail.start, "dd mmm yyyy")# #timeFormat(eventDetail.start, "HH:mm")# to #dateFormat(eventDetail.end, "dd mmm yyyy")# #timeFormat(eventDetail.end, "HH:mm")# (#getDateTimeMessage(eventDetail.start)#) - #regions#
			</a>

		</li>
	</cfloop>
</cfoutput>