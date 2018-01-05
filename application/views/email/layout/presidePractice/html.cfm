<cfscript>
	param name="args.subject"        type="string" default="";
	param name="args.body"           type="string" default="";
	param name="args.viewOnlineLink" type="string" default="";
</cfscript>
<cfoutput>
	<html>
		<head>
			<title>#args.subject#</title>
		</head>
		<h1>Preside Practice</h1>
		<body>
			<table>
				<tr>
					<td>#args.body#</td>
				</tr>
				<tr>
					<td>View in browser: #args.viewOnlineLink#</td>
				</tr>
			</table>
		</body>
	</html>
</cfoutput>