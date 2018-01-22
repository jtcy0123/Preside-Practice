<cfscript>
	param name="args.subject"        type="string" default="";
	param name="args.body"           type="string" default="";
	param name="args.viewOnlineLink" type="string" default="";
</cfscript>
<cfoutput>
Preside Practice

#args.body#
View in browser: #args.viewOnlineLink#
</cfoutput>