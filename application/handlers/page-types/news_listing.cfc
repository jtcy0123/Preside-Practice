component {
	property name="presideObjectService" inject="presideObjectService";
	property name="siteTreeService"      inject="siteTreeService";

	private function index( event, rc, prc, args={} ) {
		args.news = presideObjectService.selectData(
						  objectName = "news"
						, orderby    = "published_date"
					);

		return renderView(
			  view          = 'page-types/news_listing/index'
			, presideObject = 'news_listing'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function detail( event, rc, prc, args={} ) {
		if(!len(prc.newsSlug?:"")) event.notFound();

		args.newsDetail = presideObjectService.selectData(
							  objectName = "news"
							, filter 	 = { slug=prc.newsSlug }
						  );

		if(!args.newsDetail.recordcount) event.notFound();

		args.parentListingPage = siteTreeService.getPage( "news_listing" );

		event.initializeDummyPresideSiteTreePage(
			  id          = args.newsDetail.id
			, title       = args.newsDetail.label
			, slug        = args.newsDetail.slug
			, parent_page = args.parentListingPage
			, page_type   = "news"
		);

		event.setView(
			  view = "page-types/news_listing/detail"
			, args = args
		);
	}
}
