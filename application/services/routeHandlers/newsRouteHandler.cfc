component implements="preside.system.services.routeHandlers.iRouteHandler" {
	// match(): return true if the incoming URL path should be handled by this route handler
    public boolean function match( required string path, required any event ) output=false {
    	return reFindNoCase( "^/news/.*?\.html", arguments.path );
    }

    // translate(): take an incoming URL and translate it - use the ColdBox event object to set variables and the current event
    public void function translate( required string path, required any event ) output=false {
    	var rc  = event.getCollection();
    	var prc = event.getCollection( private=true );

    	prc.newsSlug = reReplace( arguments.path, "/news/(.*?)\.html$", "\1" );

    	rc.event = "page-types.news_listing.detail";
    }

    // reverseMatch(): return true if the incomeing set of arguments passed to buildLink() should be handled by this route handler
    public boolean function reverseMatch( required struct buildArgs, required any event ) output=false {
    	return len( trim( buildArgs.newsSlug ?: "" ) );
    }

    // build(): take incoming buildLink() arguments and return a URL string
    public string function build( required struct buildArgs, required any event ) output=false {
    	return _getRootPath() & "/news/#buildArgs.newsSlug#.html";
    }

    private string function _getRootPath() output=false {
        var protocol = ( cgi.server_protocol.startsWith( "HTTPS" ) ? "https" : "http" ) & "://";
        var domain   = cgi.server_name;
        var port     = cgi.server_port == 80 ? "" : ":#cgi.server_port#";

        return protocol & domain & port;
    }
}