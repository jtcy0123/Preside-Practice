<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.slug"          field="page.slug"         editable="false" />

<cfscript>
	event.include( "css-case-study.less" )
		 .include( "js-case-study-listing" )
		 .include( "js-masonry" );
	event.includeData( { gridPlaceholder=[ "mod-orange", "mod-blue", "mod-grey" ] } );
</cfscript>

<cfoutput>

	<div class="contents" >

		<div class="contect-section banner-text text-center">

			<div class="container">

				<div class="row">

					<div class="col-xs-12 col-md-10 col-md-push-1">

						<h1>#args.title#</h1>

						#args.main_content#

					</div>

				</div>

			</div>

		</div>

		<div class="contect-section mod-grid">

			#renderView( view="page-types/our_work/_filter", args = args )#

			<div class="container">

				<div class="row">

					<div class="grid-wrapper">

						<div class="grid auto-placeholder">
							<div class="grid-sizer"></div>

							#renderView( view="page-types/our_work/_result", args = args )#

						</div>

						<div class="grid-load-more <cfif !args.hasMoreResult >hidden</cfif>"
							data-href="#event.buildLink( linkTo="page-types.our_work.loadMore" )#"
							data-maxrows="#args.maxRows#"
							data-page="2"
							data-totalresults="#args.resultsTotal#"
						>

							<div class="sk-cube-grid">
								<div class="sk-cube sk-cube1"></div>
								<div class="sk-cube sk-cube2"></div>
								<div class="sk-cube sk-cube3"></div>
								<div class="sk-cube sk-cube4"></div>
								<div class="sk-cube sk-cube5"></div>
								<div class="sk-cube sk-cube6"></div>
								<div class="sk-cube sk-cube7"></div>
								<div class="sk-cube sk-cube8"></div>
								<div class="sk-cube sk-cube9"></div>
							</div>

						</div>

					</div>

				</div>

			</div>

		</div>

	</div>

</cfoutput>