<cfset featuredEvent = args.featuredEvent ?: queryNew("")>

<cfoutput query="featuredEvent">
	<div class="well">
		<h3>#title#</h3>
		<p>Event starts from #dateFormat(start, "dd mmm yyyy")# to #dateFormat(end, "dd mmm yyyy")#</p>
		<p>Time : #timeFormat(start, "HH:mm")# to #timeFormat(end, "HH:mm")#</p>
	</div>
</cfoutput>