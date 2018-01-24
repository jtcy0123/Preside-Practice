<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<cfloop query="args.news">
		<div class="jumbotron">
			<h3><a href="#event.buildLink(newsSlug=slug)#">#label#</a></h3>
			Published on #dateFormat(published_date, "dd mmm yyyy")#
		</div>
	</cfloop>
</cfoutput>