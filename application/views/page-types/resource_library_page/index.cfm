<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfset resources     = prc.results.getResults()      />
<cfset aggregations = prc.results.getAggregations() />
<cfset event.include('js-resource_library_search').includeData({
	  resultUrl   = event.buildlink( linkTo="page-types.resource_library_page.index")
	, category    = rc.category?:""
	, region      = rc.region?:""
	, totalPages  = prc.results.getTotalPages()
})   />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<p>Total results: #prc.results.getTotalResults()#</p>
	<div class="col-md-9">
		<div id="resourcesDiv">
			#renderView( view="page-types/resource_library_page/_results")#
		</div>

		<cfif prc.results.hasnextpage() >
			<!--- <a href="/resource-library-search.html" id="showMore">
				Show More
			</a> --->
			<div class = "show-more" >
				<a id                    = "js-load-more-resources"
				   class                 = "btn thin"
			       href                  = "/resource-library-search.html"
				   data-load-more-target = "resourcesDiv"
				>
					Show more
				</a>
			</div>
		</cfif>
	</div>

	<div class="col-md-offset-1 col-md-2">
		<form name="filter" action="#event.buildLink()#" method="post" id="filterform">
			<p><u>Categor</u>ies</p>
			<cfloop array="#aggregations.category#" index="category">
				<cfset checked = listFindNoCase(rc.category, category.key) />
				<div class="checkbox">
					<label>
						<input type="checkbox" name="category" value="#category.key#" <cfif checked>checked</cfif>>
						#category.label#
					</label>
				</div>
			</cfloop>
			<hr>
			<p><u>Regions</u></p>
			<cfloop array="#aggregations.region#" index="region">
				<cfset checked = listFindNoCase(rc.region, region.key) />
				<div class="checkbox">
					<label>
						<input type="checkbox" name="region" value="#region.key#" <cfif checked>checked</cfif>>
						#region.label#
					</label>
				</div>
			</cfloop>
			<!--- <input type="submit" value="Submit" /> --->
		</form>
	</div>

</cfoutput>