<cfoutput>

	<div class="filter" id="grid-filter" >

		<form action="#event.buildLink( linkTo="page-types.our_work.applyNewFilter" )#" method="get" id="grid-filter-form" class="filter-main-wrapper" data-subfilter="#event.buildLink( linkTo="page-types.our_work.getSecondaryTags" )#" >
			<input type="hidden" class="hdn-base-url" value="/#args.slug#" >


			<div class="container">

				<div class="width-controller">

					<div class="row">

						<div class="col-xs-12 col-md-12">

							<nav class="filter-nav">

								<ul class="filter-nav-main">
									<li class="filter-nav-main-item <cfif isEmpty(args.primaryTag) >is-active</cfif>">
										<a href="##" class="js-main-filter" data-filter="all-work" >All work</a>
										<input type="radio" class="js-checkbox-main-filter" name="primary_tag" value="all-work" <cfif isEmpty(args.primaryTag) >checked</cfif> >
									</li>
									<cfloop query="args.tags" >
										<li class="filter-nav-main-item <cfif args.primaryTag == slug >is-active</cfif>">
											<a href="##" class="js-main-filter" data-filter="#slug#" >#label#</a>
											<input type="radio" class="js-checkbox-main-filter" name="primary_tag" value="#slug#" <cfif args.primaryTag == slug >checked</cfif> >
										</li>
									</cfloop>
								</ul>

								<a href="##" class="filter-nav-trigger js-show-mobile-filter"></a>

							</nav>

							<nav class="filter-nav-sub" <cfif !isEmpty( args.subFilterHtml ) >style="display:block;"</cfif> >
								#args.subFilterHtml#
							</nav>

						</div>

					</div>

				</div>

			</div>

		</form>

	</div>

</cfoutput>