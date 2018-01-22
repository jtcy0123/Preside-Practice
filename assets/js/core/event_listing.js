$(function() {
    var loadMoreBtn    = $('#load_more');
    if( cfrequest && loadMoreBtn[0] ) {
	    var eventListingUl = $('#event_listing');
	    var page           = cfrequest.currentPage + 1;
	    var region 		   = cfrequest.region;
	    var category 	   = cfrequest.category;
	    var totalPage      = cfrequest.totalPage;
	    var listingUrl     = cfrequest.eventListingPage;

		loadMoreBtn[0].onclick = function(event){
			event.preventDefault();

			$.ajax({type: "GET",
                url: listingUrl,
                data: { page: page, region: region, category: category },
	            success: function(result){
	            			eventListingUl.append(result);

	            			if(page >= totalPage ) loadMoreBtn.hide();
	        			 }
			});
		};
	}
});