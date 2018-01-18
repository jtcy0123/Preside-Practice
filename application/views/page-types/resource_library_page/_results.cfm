<cfset resources = prc.results.getResults() />

<cfoutput>
	<cfloop query="resources" >
		<cfif !isArray(region)><cfset var region = "#listToArray(region)#" /></cfif>
		<div class="well col-md-6 center">
			<h3>#title#</h3>
			<p>Category: #renderlabel("category",category)#</p>
			<p>Regions:
				<cfloop array="#region#" item="reg">
					#renderLabel( "region" , reg )# <cfif reg neq arrayLast(region)>,</cfif>
				</cfloop>
			</p>
		</div>
	</cfloop>
	<input type="hidden" id="currentPage" value="#prc.results.getPage()#">
</cfoutput>