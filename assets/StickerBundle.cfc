/**
 * Sticker bundle configuration file. See: http://sticker.readthedocs.org/
 */
component {

	public void function configure( bundle ) {

		bundle.addAssets(
			  directory   = "/"
			, match       = function( filepath ){ return ReFindNoCase( "\.(js|css)$", filepath ); }
			, idGenerator = function( filepath ){
				var fileName = ListLast( filePath, "/" );
				var id       = ListLast( filename, "." ) & "-" & ReReplace( filename, "\.(js|css)$", "" );
				return id;
			  }
		);

		bundle.addAsset( id="jq-imagesloaded", path="/js/lib/imagesloaded.pkgd.min.js");
		bundle.addAsset( id="jq-masonry"     , path="/js/lib/masonry.pkgd.min.js"     );

		bundle.asset( "css-bootstrap" ).before( "*" );
		bundle.asset( "js-bootstrap" ).dependsOn( "js-jquery" );
		// masonry bundle -- just include "/js/specific/masonry/" on specific pages
		bundle.asset( "js-masonry" ).dependsOn( "jq-masonry", "jq-imagesloaded" );
	}

}