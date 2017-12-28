<cfset expiredEvent = args.expiredEvent ?: queryNew("")>

<cfoutput query="expiredEvent">
	<li>
		<a href="#event.buildLink(page=expiredEvent.id)#">
			<strong>#title#</strong> on #dateFormat(start, "dd mmm yyyy")# to #dateFormat(end, "dd mmm yyyy")#
		</a>
	</li>
</cfoutput>