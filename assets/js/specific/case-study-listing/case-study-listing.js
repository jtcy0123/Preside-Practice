var isFetchingNewResults  = false;
var isFetchingMoreResults = false;
var itemFetchCtr          = 0;
var timeoutCtr            = 0;

var caseStudyListingFilter = function( $grid, $gridLoadMore ) {
	var $gridFilter       = $( "#grid-filter" );
	var $gridFilterForm   = $( "#grid-filter-form" );
	var ajaxSubfilter     = null;
	var ajaxSubfilterData = null;
	var ajaxNewResult     = null;
	var ajaxNewResultData = null;

	$( ".js-main-filter" ).click( function(e) {
		e.preventDefault();
		var $this          = $( this );
		var $filterNavMain = $this.closest( ".filter-nav-main" );
		var data           = {};
		data[ $this.next().attr( "name" ) ] = $this.data( "filter" );
		ajaxSubfilterData = data;


		if( PIXL8.fn.viewport().width <= PIXL8.mediaWidth.SM ) {

			if( !$filterNavMain.hasClass( "show-filters" ) ) {
				$filterNavMain.addClass( "show-filters" );
				$( ".js-show-mobile-filter" ).addClass( "is-active" );
				return;
			}
			$filterNavMain.removeClass( "show-filters" );
			$( ".js-show-mobile-filter" ).removeClass( "is-active" );

		}

		$this.parent().addClass( "is-active" ).siblings().removeClass( "is-active" );
		$this.next().prop( "checked", true ).trigger( "change" );
	} );

	$( ".filter-nav-sub" ).on( "click", ".js-sub-filter", function(e) {
		e.preventDefault();
		var $this = $( this );

		$this.parent().siblings( ".is-selected" ).removeClass( "is-selected" ).find( "input" ).prop( "checked", false );
		$this.parent().toggleClass( "is-selected" );
		if( $this.parent().hasClass( "is-selected" ) ) {
			$this.next().prop( "checked", true ).trigger( "change" );
		} else {
			$this.next().prop( "checked", false ).trigger( "change" );
		}

	} );

	$( ".js-show-mobile-filter" ).click( function(e) {
		e.preventDefault();
		var $filterNavMain = $( this ).prev( ".filter-nav-main" );
		$filterNavMain.toggleClass( "show-filters" );
		$( this) .toggleClass( "is-active" );
	} );

	$( window ).scroll( function() {
		var $filterNav    = $( ".filter-nav" );
		var $filterNavSub = $( ".filter-nav-sub" );

		if( $( this ).scrollTop() >= $gridFilter.offset().top ) {
			$gridFilter.addClass( "fixed" );
		} else {
			$gridFilter.removeClass( "fixed" );
		}
	});

	$gridFilterForm.on( "change", "input[type='checkbox'], input[type='radio']", function() {
		if( ajaxNewResult != null ) {
			ajaxNewResult.abort();
		}
		var data                = { fetchSecondaryFilter : false };
		var $subFilterContainer = $( ".filter-nav-sub" );
		var $mainFilter         = $( "#grid-filter-form .js-checkbox-main-filter:checked" );
		var mainFilterValue     = $mainFilter.val();
		var $subFilter          = $( "#grid-filter-form .js-checkbox-sub-filter:checked" );
		var subFilterValue      = $subFilter.val();
		var href                = $gridFilterForm.attr( "action" );

		data.maxRows                       = $gridLoadMore.data( "maxrows" );
		data[ $mainFilter.attr( "name" ) ] = mainFilterValue;

		if( $(this).hasClass( "js-checkbox-main-filter" ) ) {
			subFilterValue            = "";
			data.fetchSecondaryFilter = true;
			$subFilterContainer.hide().empty();
			$gridFilter.removeClass( "filter-shown" );
		}

		if( $subFilter.length ) {
			data[ $subFilter.attr( "name" ) ] = subFilterValue;
		}

		ajaxNewResultData = data;

		updateUrl( mainFilterValue, subFilterValue );

		$gridLoadMore.show();
		$grid.masonry( "remove", $grid.find( ".grid-item" ) );
		$grid.find( ".grid-item" ).remove();
		$grid.masonry();

		isFetchingNewResults = true;
		fetchNewItems( href, data );

	} );

	var updateUrl = function( mainFilter, subFilter ) {
		var pathname = $( ".hdn-base-url" ).val();
		mainFilter = mainFilter == undefined ? "" : mainFilter;
		subFilter  = subFilter  == undefined ? "" : subFilter;

		if (history.pushState) {
			var newurl = window.location.protocol + "//" + window.location.host + pathname;

			if( mainFilter == "all-work" ) {
				newurl += ".html";
			} else {
				if( mainFilter.length ) {
					newurl += "/" + mainFilter;
				}
				if( subFilter.length ) {
					newurl += "/" + subFilter;
				}
				newurl += "/";
			}
			window.history.pushState( { path:newurl }, "", newurl );
		}

	}

	var fetchNewItems = function( href, data ) {
		var $subFilterContainer = $( ".filter-nav-sub" );

		ajaxNewResult = $.ajax({
			  method   : "get"
			, url      : href
			, cache    : false
			, data     : data
			, dataType : "json"
			, success  : function( response, responseCode, jqxhr ) {
				if( ajaxNewResultData == ajaxNewResult.data ) {
					var $items     = $( response.results );
					var $subFilter = $( response.subFilter );

					$subFilterContainer.show().append( $subFilter );
					$gridFilter.addClass( "filter-shown" );

					$gridLoadMore.data( "page", 2 );
					$gridLoadMore.data( "totalresults", response.results_total );

					if( $grid.hasClass( "auto-placeholder" ) ) {
						PIXL8.assignGridPlaceholder( $items.find( ".grid-item-content.mod-placeholder" ), 0 );
					}

					$items.addClass( "is-loading" );
					$grid.append( $items ).masonry( "appended", $items );
					$grid.masonry( "reloadItems" );
					isFetchingNewResults  = false;
					isFetchingMoreResults = false;
					itemFetchCtr          = 0;
					timeoutCtr            = 0;
					$gridLoadMore.hide();
					ajaxNewResult = null;

					$items.imagesLoaded( { background : ".grid-item-content" } )
						.progress( onProgress );

					function onProgress( imgLoad, image ) {
						$( image.element ).parent().addClass( "is-loaded" ).removeClass( "is-loading" );
					}
				}
			}
		});
		ajaxNewResult.data = data;

	};



};

var caseStudyListingGrid= function( $grid, $gridLoadMore ) {

	$( window ).scroll( function() {
		if( isFetchingMoreResults || isFetchingNewResults ) {
			return;
		}
		var viewPort   = $( window ).scrollTop() + $( window ).height();
		var gridBottom = $grid.offset().top + $grid.height();
		var offset     = 610;
		var hasMore    = $gridLoadMore.data( "totalresults" ) >= $gridLoadMore.data( "maxrows" ) * $gridLoadMore.data( "page" );

		if( viewPort > gridBottom - offset && itemFetchCtr == timeoutCtr && hasMore ) {
			$gridLoadMore.slideDown();
			isFetchingMoreResults = true;
			var href = $gridLoadMore.data( "href" );
			var data = getGridFilterData();
			data.maxRows = $gridLoadMore.data( "maxrows" );
			data.page    = $gridLoadMore.data( "page" );

			fetchMasonryItems( href, data );
		} else {
			$gridLoadMore.slideUp();
		}

	});

	var fetchMasonryItems = function( href, data ) {

		$.ajax({
			  method  : "get"
			, url     : href
			, data    : data
			, cache   : false
			, success : function( items ) {
				if ( isFetchingNewResults ) return;
				var msnry   = $grid.data( "masonry" );
				var $items  = $( items ).hide();

				if( $grid.hasClass( "auto-placeholder" ) ) {
					PIXL8.assignGridPlaceholder( $items.find( ".grid-item-content.mod-placeholder" ), $grid.find( ".grid-item-content.mod-placeholder" ).length );
				}

				$gridLoadMore.data( "page", data.page + 1 );
				$items.addClass( "is-loading" );
				itemFetchCtr += $items.length;
				$grid.append( $items );
				isFetchingMoreResults = false;

				$items.each( function( index ) {
					var $item = $( this );
					setTimeout( function( index ) {
						if ( isFetchingNewResults ) return;
						$item.show();
						msnry.appended( $item );
						timeoutCtr++;
						if( timeoutCtr == itemFetchCtr ) {
							$gridLoadMore.hide();
							$( window ).trigger( "scroll" );
						}
					}, 100 * ( index + 1) );
				} );

				$items.imagesLoaded( { background : ".grid-item-content" } )
					.progress( onProgress );

				function onProgress( imgLoad, image ) {
					$( image.element ).parent().addClass( "is-loaded" ).removeClass( "is-loading" );
				}
			}
		});

	}

};getGridFilterData = function() {
	var data            = {};
	var $mainFilter     = $( "#grid-filter-form .js-checkbox-main-filter:checked" );
	var mainFilterValue = $mainFilter.val();
	var $subFilter      = $( "#grid-filter-form .js-checkbox-sub-filter:checked" );
	var subFilterValue  = $subFilter.val();

	data[ $mainFilter.attr( "name" ) ] = mainFilterValue;

	if( $subFilter.length ) {
		data[ $subFilter.attr( "name" ) ] = subFilterValue;
	}

	return data;
};

( function( $ ) {

	$( document ).ready( function() {
		var $grid         = $(".grid");
		var $gridLoadMore = $( ".grid-load-more" );

		caseStudyListingFilter( $grid, $gridLoadMore );
		caseStudyListingGrid( $grid, $gridLoadMore );

	} );

} )( jQuery );