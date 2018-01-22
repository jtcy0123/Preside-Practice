<cfparam name="args.title" />
<cfparam name="args.message" />

<cfset var addthisId = getSystemSetting(category="addThis",setting="addthis_id") />
<cfset event.include( "css-bootstrap" ) />
<cfset event.include( "css-layout" )    />
<cfset event.include( "js-bootstrap" )  />
<cfset event.include( "js-jquery" )     />

<cfoutput><!DOCTYPE html>
<html>
	<head>
		<title>#args.title#</title>
		#event.renderIncludes( "css" )#
		<meta charset="utf-8">
		<meta name="robots" content="noindex,nofollow" />
		<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js##pubid=#addthisId#"></script>
	</head>
	<body>
		<div class="container">
			<div class="header">
				<ul class="nav nav-pills pull-right">
					#renderViewlet( "core.navigation.mainNavigation" )#
				</ul>
				<h3 class="text-muted"><a href="/">Preside CMS</a></h3>
			</div>

			<div class="jumbotron">
				<h1>#args.title#</h1>
				#args.message#
			</div>

			<div class="footer">
				<!-- Go to www.addthis.com/dashboard to customize your tools -->
				<div class="addthis_inline_share_toolbox"></div>

				<p>&copy; Pixl8 2013-#Year( Now() )#</p>
			</div>
		</div>
	</body>
</html></cfoutput>