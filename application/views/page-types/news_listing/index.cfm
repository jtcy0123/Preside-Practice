<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<ul>
		<cfloop query="args.news">
			<li><a href="#event.buildLink(newsSlug=slug)#">#label#</a></li>
		</cfloop>
	</ul>
</cfoutput>