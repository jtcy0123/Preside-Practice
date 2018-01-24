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

		_setupEmailSettings();
		_setupInterceptors();

		settings.notificationTopics.append( "newBooking" );
		settings.notificationTopics.append( "seatsSoldOut" );

		coldbox.requestContextDecorator = "app.decorators.RequestContextDecorator";

		settings.features.formbuilder.enabled = true;
		settings.formbuilder.itemTypes.multipleChoice.types.selectSeat = { isFormField = true };
		settings.formbuilder.itemTypes.multipleChoice.types.objectSessionCheckbox = { isFormField = true };
		settings.formbuilder.actions.append( "eventBooking" );

		settings.websitePermissions.comments = [ "add", "edit" ];

		settings.features.multilingual.enabled = true;
	}

	private struct function _getConfiguredAssetDerivatives() {
		var derivatives = super._getConfiguredAssetDerivatives();

		derivatives.mainImage = {
			  permissions     = "inherit"
			, transformations = [
				 { method="shrinkToFit", args={ width=700, height=450 } }
			  ]
		};

		derivatives.eventPdf  = {
			  permissions     = "inherit"
			, transformations = [
				   { method="pdfPreview" , args={ page=1 }, inputfiletype="pdf", outputfiletype="jpg" }
				 , { method="shrinkToFit", args={ width=100, height=100 } }
			  ]
		};

		return derivatives;
	}

	private function _setupEmailSettings() {
		settings.email.templates.bookingConfirmation = {
			  recipientType = "anonymous"
			, parameters    = [
				{ id="bookingSummary", required=true }
			]
		};
	}

	private void function _setupInterceptors() {
		interceptors.append( { class="app.interceptors.EventBookingInterceptor", properties={} } );
	}
}
