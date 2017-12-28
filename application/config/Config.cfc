component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "admin";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "presidepractice";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "presidepractice";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;

		settings.assetmanager.derivatives = _getConfiguredAssetDerivatives();
	}

	private struct function _getConfiguredAssetDerivatives() {
		var derivatives  = super._getConfiguredAssetDerivatives();

		derivatives.mainImage = {
			  permissions = "inherit"
			, transformations = [
				 { method="shrinkToFit", args={ width=700, height=450 } }
			  ]
		};

		derivatives.eventPdf = {
			  permissions = "inherit"
			, transformations = [
				   { method="pdfPreview" , args={ page=1 }, inputfiletype="pdf", outputfiletype="jpg" }
				 , { method="shrinkToFit", args={ width=100, height=100 } }
			  ]
		};

		return derivatives;

	}
}
