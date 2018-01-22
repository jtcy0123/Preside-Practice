<cfset event.include( "css-bootstrap" ) />
<cfset var addthisId = getSystemSetting(category="addThis",setting="addthis_id") />

<cfoutput><!DOCTYPE html>
<html>
	<head>
		#renderView( "/general/_pageMetaForHtmlHead" )#
		#event.renderincludes( "css" )#
		<style type="text/css">
			body {
				background-color: ##999;
			}
		</style>
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

			#renderView()#

			<div class="footer">
				<!-- Go to www.addthis.com/dashboard to customize your tools -->
				<div class="addthis_inline_share_toolbox"></div>

				<p>&copy; Pixl8 2013-#Year( Now() )#</p>
			</div>
		</div>
	</body>
</html>
</cfoutput>