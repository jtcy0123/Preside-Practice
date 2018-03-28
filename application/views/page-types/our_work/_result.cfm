<cfscript>
	results = args.results ?: queryNew("");
	args.maxrows = args.maxrows ?: "99999";
</cfscript>

<cfoutput>

	<cfloop query="results" startrow="1" endrow="#args.maxRows#" >
		#renderView(
			  view = "general/_grid"
			, args = {
				  title               = title
				, grid_type           = grid_type
				, image               = image
				, link                = link
				, show_button         = show_button
				, button_text         = button_text
			}
		)#
	</cfloop>

</cfoutput>