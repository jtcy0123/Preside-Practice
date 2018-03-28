<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.main_image"  field="page.main_image" editable="false" />

<cfoutput>
	<h1>#args.title#</h1>
	#renderAsset(assetId=args.main_image, args={derivative="mainImage"})#

	#event.buildLink(assetId=args.main_image, derivative="mainImage")#

	#args.main_content#
</cfoutput>