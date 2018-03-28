PIXL8.assignGridPlaceholder = function( $gridItems, itemCount ) {

	var gridPlaceholder = [ "mod-orange", "mod-blue", "mod-grey" ];
	if( cfrequest != undefined ) {
		gridPlaceholder = !(typeof( cfrequest.GRIDPLACEHOLDER ) === "undefined") ? cfrequest.GRIDPLACEHOLDER : gridPlaceholder;
	}

	$gridItems.each( function( index ) {
		$( this ).addClass( gridPlaceholder[ (index + itemCount) % 3 ] )
	} );

};

PIXL8.masonryHandler = function() {

	var $grid = $( ".grid" ).masonry({
		  itemSelector       : ".grid-item"
		, columnWidth        : ".grid-sizer"
		, percentPosition    : true
		, transitionDuration : "0.8s"
	} );

	if( $grid.hasClass( "auto-placeholder" ) ) {
		PIXL8.assignGridPlaceholder( $grid.find( ".grid-item-content.mod-placeholder" ), 0 );
	}

	$grid.find( ".grid-item" ).addClass( "is-loading" );

	$grid.imagesLoaded( { background : ".grid-item-content" } )
		.progress( onProgress );

	function onProgress( imgLoad, image ) {
		$( image.element ).parent().addClass( "is-loaded" ).removeClass( "is-loading" );
	}
};

( function( $ ) {

	$( document ).ready( function() {

		PIXL8.masonryHandler();

	} );

} )( jQuery );