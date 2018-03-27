<cf_presideparam name="args.title"         field="page.title"        editable="true"  />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true"  />
<cf_presideparam name="args.success_message"                         editable="false" />
<cf_presideparam name="args.error_message"                           editable="false" />

<cfoutput>
	<cfif rc.success?:false>
		#args.success_message#
	</cfif>
</cfoutput>