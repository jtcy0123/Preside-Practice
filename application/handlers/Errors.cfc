component {

	private string function notFound( event, rc, prc, args={} ) {
		event.setHTTPHeader( statusCode="404" );
		event.setHTTPHeader( name="X-Robots-Tag", value="noindex" );
		// event.nolayout();
		event.setLayout( "404Layout" );

		event.initializePresideSiteteePage( systemPage="notFound" );
		return renderView( view="/errors/notFound", presideObject="notFound", id=event.getCurrentPageId(), args=args );
	}
}