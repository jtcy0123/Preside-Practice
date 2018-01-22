<cf_presideparam name="args.title"          field="page.title"                      editable="true"  />
<cf_presideparam name="args.main_content"   field="page.main_content"               editable="true"  />
<cf_presideparam name="args.bottom_content" field="page.bottom_content"             editable="true"  />
<cf_presideparam name="args.featured_event" field="GROUP_CONCAT(featured_event.id)" editable="false" />

<cfset event.include( "js-event_listing" ).includeData({
	  currentPage      = rc.page?:1
	, region           = rc.region?:""
	, category         = rc.category?:""
	, totalPage        = rc.totalPage?:""
	, eventListingPage = event.buildLink(page=event.getCurrentPageId())
}) />

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

	<ul id="event_listing">
		#renderView(
			  view = "page-types/event_listing/_eventDetail2"
			, args = args
		)#
	</ul>
	<cfif rc.totalPage EQ 0>
		<p>No result found.</p>
	<cfelseif rc.totalPage GT 1>
		<a href="/event.html" id="load_more">Load more</a>
	</cfif>

	<br>
	<h4><u>Expired Events</u></h4>
	#renderViewlet( event="page-types.event_detail.expiredEvent" )#

	<p>#args.bottom_content#</p>

</cfoutput>