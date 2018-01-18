<cfscript>
	pageUrl  = event.buildLink( page='#prc.eventDetail.id#' );
	disqusId = getSystemSetting(category="disqus",setting="disqus_id");
</cfscript>

<cfoutput>
	#dateDiff("w", now(), prc.eventDetail.start)#
	<div class="well">
		<cfif #prc.eventDetail.start# LT now() >
			<h4>#prc.eventDetail.title# (Expired)</h4>
			<cfset pdfImage = event.buildLink(assetId=prc.eventDetail.document, derivative="eventPdf")>
			<a href="#event.buildLink(assetId=prc.eventDetail.document)#">
				<img src="#pdfImage#" alt=""/>Download
			</a>
		<cfelse>
			<h3>#prc.eventDetail.title#</h3>
		</cfif>

		<p>Event starts from #dateFormat(prc.eventDetail.start, "dd mmm yyyy")# to #dateFormat(prc.eventDetail.end, "dd mmm yyyy")# (#getDateTimeMessage(prc.eventDetail.start)#)</p>
		<p>Time : #timeFormat(prc.eventDetail.start, "HH:mm")# to #timeFormat(prc.eventDetail.end, "HH:mm")#</p>

		<cfif #prc.eventDetail.start# GTE now() && #prc.eventDetail.bookable# >
			<cfif prc.condition >
				<i>You have booked on this event!</i>
			<cfelseif event.fullyBooked( #prc.eventDetail.id# ) >
				<i>Sorry, event fully booked.</i>
			<cfelse>
				<a href="#event.buildLink(page="event_booking_page", querystring="evid=#prc.eventDetail.id#")#">Book now</a><br>
				<i>#val(prc.eventDetail.total_seats - prc.eventDetail.seats_booked)# seats left!</i>
			</cfif>
		<cfelse>
			<i>Not bookable at the moment.</i>
		</cfif>
	</div>

	#renderView(
	      view          = "page-types/event_detail/_programme"
	    , presideObject = "programme"
	    , filter        = { event_detail = prc.eventDetail.id }
	    , args 			= args
	)#

	<hr/>

	<cfif #prc.eventDetail.start# LT now() >
		<div id="disqus_thread"></div>
		<script>
		    var disqus_config = function () {
		        this.page.url = '#pageUrl#';  // Replace PAGE_URL with your page's canonical URL variable
		        this.page.identifier = '#prc.eventDetail.id#'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
		    };
		    (function() {  // REQUIRED CONFIGURATION VARIABLE: EDIT THE SHORTNAME BELOW
		        var d = document, s = d.createElement('script');

		        s.src = 'https://#disqusId#.disqus.com/embed.js';  // IMPORTANT: Replace EXAMPLE with your forum shortname!

		        s.setAttribute('data-timestamp', +new Date());
		        (d.head || d.body).appendChild(s);
		    })();
		</script>
	<cfelse>
		#renderViewlet( event="page-types.event_detail.relatedEvent", args={ excludeEventId=prc.eventDetail.id, regionIds = prc.eventDetail.regionIds} )#
	</cfif>

</cfoutput>