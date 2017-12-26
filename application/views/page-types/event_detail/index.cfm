<cf_presideparam name="args.title"          field="page.title"              editable="true"  />
<cf_presideparam name="args.main_content"   field="page.main_content"       editable="true"  />
<cf_presideparam name="args.bottom_content" field="page.bottom_content"     editable="true"  />
<cf_presideparam name="args.startdate"		                                editable="false" />
<cf_presideparam name="args.enddate"		                                editable="false" />
<cf_presideparam name="args.pageId" 		field="page.id"		            editable="false" />
<cf_presideparam name="args.region"  		field="GROUP_CONCAT(region.id)" editable="false" />


<cfoutput>
	<div class="well">
		<h3>#args.title#</h3>
		<p>Event starts from #dateFormat(args.startdate, "dd mmm yyyy")# to #dateFormat(args.enddate, "dd mmm yyyy")#</p>
		<p>Time : #timeFormat(args.startdate, "HH:mm")# to #timeFormat(args.enddate, "HH:mm")#</p>
	</div>

	#renderView(
		      view          = "page-types/event_detail/_programme"
		    , presideObject = "programme"
		    , filter        = { event_detail = event.getCurrentPageId() }
		    , args 			= args
		)#

	<hr>
	#renderViewlet( event="page-types.event_detail.relatedEvent", args={ excludeEventId=args.pageId, regionIds = args.region} )#

</cfoutput>