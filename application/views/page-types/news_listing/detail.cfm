<cfoutput>
	<h1>#args.newsDetail.label?:""#</h1>
	<p>Published on #dateFormat(args.newsDetail.published_date, "dd mmm yyyy")#</p>
	<div class="well">
		#args.newsDetail.content?:""#
	</div>
</cfoutput>