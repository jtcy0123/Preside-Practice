component extends="preside.system.handlers.General" {

	function requestStart( event, rc, prc ) {
		super.requestStart( argumentCollection = arguments );

		var defaultLanguage = getModel( "SystemConfigurationService" ).getSetting(category="multilingual", setting="default_language");
		event.setLanguage( defaultLanguage );
	}
}