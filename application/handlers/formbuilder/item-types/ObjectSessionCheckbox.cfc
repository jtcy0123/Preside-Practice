component {
	property name="presideObjectService" inject="presideObjectService";

	private function renderInput( event, rc, prc, args={} ) {

		var eventId = rc.evid ?: "" ;

		var qObj = presideObjectService.selectData(
			  objectName="session"
			, filter = { "event_detail" = eventId }
			, orderBy="label"
		);

		args.values=valueArray( qObj.id );
		args.labels=valueArray( qObj.label );

		var controlName = args.name ?: "";

		return renderFormControl(
			  argumentCollection = args
			, name               = controlName
			, type               = "objectSessionCheckbox"
			, context            = "formbuilder"
			, id                 = args.id ?: controlName
			, layout             = ""
			, required           = IsTrue( args.mandatory ?: "" )
			, values             = args.values
			, labels             = args.labels
		);
	}
}
