<cfparam type="string"  name="args.title"               default="" >
<cfparam type="string"  name="args.image"               default="" >
<cfparam type="string"  name="args.grid_type"           default="" >

<cfparam type="string"  name="args.link"                default="" >
<cfparam type="string"  name="args.button_text"         default="Explore" >
<cfparam type="string"  name="args.show_button"         default=true >

	<cfset resizeimage       = "" />
	<cfset itemExtraClass    = "" />
	<cfset contentExtraClass = "" />

	<cfif !isEmpty(args.image) >

		<cfif args.grid_type == "" or args.grid_type == "small">
			<cfset resizeimage = event.buildLink( assetId=args.image, derivative="square_grid" ) />
		<cfelseif args.grid_type == "medium">
			<cfset resizeimage      = event.buildLink( assetId=args.image, derivative="wide_grid" ) />
			<cfset itemExtraClass = "x2" />
		<cfelseif args.grid_type == "large">
			<cfset resizeimage      = event.buildLink( assetId=args.image, derivative="full_grid" ) />
			<cfset itemExtraClass = "x4" />
		</cfif>
	<cfelse>
		<cfset contentExtraClass = "mod-placeholder" />
	</cfif>

<cfoutput>

	<div class="grid-item #itemextraclass#">
		<div class="grid-item-content #contentextraclass#" <cfif !isEmpty(resizeimage)> style="background-image: url(#resizeimage#);"</cfif> >
			<div class="display-table">
				<div class="display-table-cell">
					<h3>#renderLink( id=args.link, body=args.title )#</h3>
					<!--- <cfif isTrue(args.show_button) >
						<p class="btn-wrapper">#renderLink( id=args.link, body="<span class='btn-expand-text'>"&args.button_text&"</span>", class="btn-expand" )#</p>
					</cfif> --->
				</div>
			</div>
			#renderLink( id=args.link, body=args.title, class="grid-item-content-link" )#
		</div>
	</div>

</cfoutput>