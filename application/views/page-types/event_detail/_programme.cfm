<cf_presideparam name="args.label"         />
<cf_presideparam name="args.startdatetime" />

<cfoutput>
	<li>
		<strong>#args.label#</strong> on #dateFormat(args.startdatetime, "dd mmm yyyy")# at #timeFormat(args.startdatetime, "HH:mm")#
	</li>
</cfoutput>