<cf_presideparam name="args.title"          field="page.title"                      editable="true"  />
<cf_presideparam name="args.main_content"   field="page.main_content"               editable="true"  />
<cf_presideparam name="args.bottom_content" field="page.bottom_content"             editable="true"  />
<cf_presideparam name="args.featured_event" field="GROUP_CONCAT(featured_event.id)" editable="false" />

<cfset eventDetail = prc.eventDetail?:QueryNew("")>
<cfoutput>
	<h1>#args.title#</h1>
	<p>#args.main_content#</p>

	#renderViewlet( event="page-types.event_listing.featuredEvent", args={ eventIds = args.featured_event} )#

	<form name="filter" action="#event.buildLink()#" method="post">
		<select id="category" name="category">
				<option value="">Choose Category</option>
			<cfloop query="#prc.category?:queryNew("")#">
				<option value="#id#" <cfif (rc.category?:"") eq id>selected</cfif>  >#label#</option>
			</cfloop>
		</select>

		<select id="region" name="region">
				<option value="">Choose Region</option>
			<cfloop query="#prc.region?:queryNew("")#">
				<option value="#id#" <cfif (rc.region?:"") eq id>selected</cfif>  >#label#</option>
			</cfloop>
		</select>

		<input type="submit" value="filter">
	</form>

	<ul>
		<cfloop query="eventDetail">
			<li>
				<a href="#event.buildLink(page=eventDetail.id)#">
					<strong>#eventDetail.title#</strong> from #dateFormat(eventDetail.start, "dd mmm yyyy")# #timeFormat(eventDetail.start, "HH:mm")# to #dateFormat(eventDetail.end, "dd mmm yyyy")# #timeFormat(eventDetail.end, "HH:mm")#
				</a>

			</li>
		</cfloop>
	</ul>

	<br>
	<h4><u>Expired Events</u></h4>
	#renderViewlet( event="page-types.event_detail.expiredEvent" )#

	<p>#args.bottom_content#</p>

</cfoutput>