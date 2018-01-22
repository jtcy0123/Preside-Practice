<cfscript>
	inputName      = args.name                   ?: "";
	inputId        = args.name                   ?: "";
	inputClass     = args.class                  ?: "";
	seatsAvailable = args.seatsAvailable         ?: "";
	label          = args.label                  ?: "";
</cfscript>

<cfoutput>
	<cfif len( seatsAvailable ) >
		<cfif seatsAvailable GTE 1 >
			<select class="#inputClass#" name="#inputName#" id="#inputId#">
				<cfloop from="1" to="#seatsAvailable#" index="index">
					<option value="#index#"> #index# </option>
				</cfloop>
			</select>
		<cfelse>
			<p>No more seats available</p>
		</cfif>
	<cfelse>
		<input type ="number" class="#inputClass#" name="#inputName#" id="#inputId#" placeholder="#label#"/>
	</cfif>
</cfoutput>