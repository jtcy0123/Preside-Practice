<cf_presideparam name="args.title"          field="page.title"              editable="true"  />
<cf_presideparam name="args.main_content"   field="page.main_content"       editable="true"  />
<cf_presideparam name="args.bottom_content" field="page.bottom_content"     editable="true"  />
<cf_presideparam name="args.startdate"		                                editable="false" />
<cf_presideparam name="args.enddate"		                                editable="false" />
<cf_presideparam name="args.document"		                                editable="false" />
<cf_presideparam name="args.bookable"		                                editable="false" />
<cf_presideparam name="args.pageId" 		field="page.id"		            editable="false" />
<cf_presideparam name="args.region"  		field="GROUP_CONCAT(region.id)" editable="false" />

<cfscript>
	pageUrl  = event.buildLink( page='#args.pageId#' );
	disqusId = getSystemSetting(category="disqus",setting="disqus_id");
</cfscript>

<cfoutput>
	<div class="well">
		<cfif #args.startdate# LT now() >
			<h4>#args.title# (Expired)</h4>
			<cfset pdfImage = event.buildLink(assetId=args.document, derivative="eventPdf")>
			<a href="#event.buildLink(assetId=args.document)#">
				<img src="#pdfImage#" alt=""/>Download
			</a>
		<cfelse>
			<h3>#args.title#</h3>
		</cfif>

		<p>Event starts from #dateFormat(args.startdate, "dd mmm yyyy")# to #dateFormat(args.enddate, "dd mmm yyyy")#</p>
		<p>Time : #timeFormat(args.startdate, "HH:mm")# to #timeFormat(args.enddate, "HH:mm")#</p>

		<cfif #args.startdate# GTE now() && #args.bookable# >
			<cfif event.fullyBooked( #args.pageId# ) >
				<i>Sorry, event fully booked.</i>
			<cfelse>
				<a href="#event.buildLink(page="event_booking_page", querystring="evid=#args.pageId#")#">Book now</a>
			</cfif>
		<cfelse>
			<i>Not bookable at the moment.</i>
		</cfif>
	</div>

	#renderView(
	      view          = "page-types/event_detail/_programme"
	    , presideObject = "programme"
	    , filter        = { event_detail = event.getCurrentPageId() }
	    , args 			= args
	)#

	<hr/>

	<cfif #args.startdate# LT now() >
		<div id="disqus_thread"></div>
		<script>
		    var disqus_config = function () {
		        this.page.url = '#pageUrl#';  // Replace PAGE_URL with your page's canonical URL variable
		        this.page.identifier = '#args.pageId#'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
		    };
		    (function() {  // REQUIRED CONFIGURATION VARIABLE: EDIT THE SHORTNAME BELOW
		        var d = document, s = d.createElement('script');

		        s.src = 'https://#disqusId#.disqus.com/embed.js';  // IMPORTANT: Replace EXAMPLE with your forum shortname!

		        s.setAttribute('data-timestamp', +new Date());
		        (d.head || d.body).appendChild(s);
		    })();
		</script>
	<cfelse>
		#renderViewlet( event="page-types.event_detail.relatedEvent", args={ excludeEventId=args.pageId, regionIds = args.region} )#
	</cfif>

</cfoutput>