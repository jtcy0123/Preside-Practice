<cfset relatedRegionEvent = args.relatedRegionEvent ?: queryNew("")>
<cfoutput query="relatedRegionEvent">
	<li>
		<a href="#event.buildLink(page=relatedRegionEvent.id)#">
			<strong>#title#</strong> from #dateFormat(start, "dd mmm yyyy")# #timeFormat(start, "HH:mm")# to #dateFormat(end, "dd mmm yyyy")# #timeFormat(end, "HH:mm")#
		</a>
	</li>
</cfoutput>