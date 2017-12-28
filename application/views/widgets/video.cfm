<cfparam name="args.title" default="" />

<cfoutput>
	<h3>#args.title#</h3>

	<ul>
		<iframe width="#args.width#" height="#args.height#" src="#args.url#" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
	</ul>
</cfoutput>