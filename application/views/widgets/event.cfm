<cfparam name="args.title" default="" />

<cfoutput>
	<h3>#args.title#</h3>

	#renderViewlet( event="page-types.event_detail.relatedEvent", args={ numEventToShow = args.number_of_events, regionIds = args.region } )#
</cfoutput>