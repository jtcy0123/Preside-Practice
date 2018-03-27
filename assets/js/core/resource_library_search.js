( function( $ ){

	$.fn.loadMore = function(){
		return this.each( function(){

			var $link            = $( this )
			  , $container       = $link.parents( '.show-more' )
			  , remoteUrl        = $link.attr( 'href' )
			  , $targetContainer = $( '#' + $link.attr( 'data-load-more-target' ) ).first()
			  , page             = 1
			  , preloaded, loadMore, preloadMore, disableLoadMore, enableLoadMore, noMore;

			loadMore = function(){
				if ( preloaded ) {
					$targetContainer.append( preloaded );
					preloadMore();
				}
				return false;
			};

			preloadMore = function(){
				var totalPages = cfrequest.totalPages;
				page++;
				disableLoadMore();
				$.ajax( {
					  url : remoteUrl
					, data : { page: page }
					, success : function( html ){ page <= totalPages ? enableLoadMore( html ) : noMore(); }
					, error : function( error ){ noMore(); }
				} );
			};

			disableLoadMore = function(){
				preloaded = null;
				$container.hide();
			};

			enableLoadMore = function( html ){
				preloaded = $.trim( html );
				$container.removeClass( "hide" );
				$container.fadeIn( 200 );
			};

			noMore = function(){
				$container.hide();
			};

			preloadMore();
			$link.click( function( e ){
				e.preventDefault();
				loadMore();
			} );
		} );

	};

	// $( "a#js-load-more" ).loadMore();
	$( "a#js-load-more-resources" ).loadMore();
	// $( "a#js-load-more-news" ).loadMore();
	// $( "a#js-load-more-events" ).loadMore();

	$('#filterform input').change(function() {
		$('#filterform').submit();
	});

} )( jQuery );


// $(function() {
// 	if (cfrequest) {
// 		$('#filterform input').change(function() {
// 			$('#filterform').submit();
// 		});

// 		if ( $('#showMore') ) {
// 			var resultUrl  = cfrequest.resultUrl;
// 			var category   = cfrequest.category;
// 			var region     = cfrequest.region;
// 			var totalPages = cfrequest.totalPages;

// 			$('#showMore').click(function(event) {
// 				var nextPage = parseInt($('#currentPage').val()) + 1;
// 				$('#currentPage').val(nextPage);

// 				event.preventDefault();

// 				$.ajax({
// 					type: "GET",
// 					url : resultUrl,
// 					data: { category: category, region: region, page: nextPage},
// 					success: function(result) {
// 						$('#resourcesDiv').append(result);

// 						if(nextPage >= totalPages) $('#showMore').hide();
// 					}
// 				})
// 			});
// 		}
// 	}
// });