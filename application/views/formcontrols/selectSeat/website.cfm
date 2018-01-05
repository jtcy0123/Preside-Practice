<cfscript>
	inputName      = args.name                   ?: "";
	inputId        = args.id                     ?: "";
	inputClass     = args.class                  ?: "";
	seatsAvailable = args.seatsAvailable         ?: "";
	label          = args.label                  ?: "";
	value 		   = args.savedData.num_of_seats ?: "";
</cfscript>

<cfoutput>
	<cfif len( seatsAvailable ) >
		<cfif seatsAvailable GTE 1 >
			<select class="#inputClass#" name="#inputName#" id="#inputId#">
				<cfloop from="1" to="#seatsAvailable#" index="index">
					<cfset selected   = ListFindNoCase( value, index ) />
					<option value="#index#"<cfif selected> selected="selected"</cfif>> #index# </option>
				</cfloop>
			</select>
		<cfelse>
			<p>No more seats available</p>
		</cfif>
	<cfelse>
		<input type ="number" class="#inputClass#" name="#inputName#" id="#inputId#" placeholder="#label#"/>
	</cfif>
</cfoutput>