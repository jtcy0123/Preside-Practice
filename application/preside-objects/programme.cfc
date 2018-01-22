component dataManagerGroup="lookup" {
	property name="startdatetime" type="date" dbtype="datetime" required="true";

	property name="event_detail" relationship="many-to-one" relatedTo="event_detail";
}