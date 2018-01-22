<cfscript>
	private string function trimHtml( required string input ) {
		return REReplaceNoCase(arguments.input, "<[^[:space:]][^>]*>", "", "ALL");
	}
</cfscript>