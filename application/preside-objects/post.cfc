component dataManagerGroup="lookup" labelfield="title" {
	property name="title"       type="string" dbtype="varchar"  maxLength="100" required="true";
	property name="publishdate" type="date"   dbtype="datetime" required="false";

	property name="image" relatedto="asset"      relationship="many-to-one"  allowedtypes="image";
	property name="subheading"     type="string"  dbtype="varchar" maxLength="400" required="false";

	property name="grid_type" type="string" dbtype="varchar"  control="select"  values="small,medium" labels="Small,Medium";
	property name="link"           relatedto="link"       relationship="many-to-one"  required="true";
	property name="tag"            relatedto="tag"        relationship="many-to-many" relatedvia="post_tags" required="false" quickadd=true quickedit=true;
	property name="show_button"    type="boolean" dbtype="boolean" required=false default=true control="hidden";
	property name="button_text"    type="string"  dbtype="varchar" maxLength="100" required="false";
	property name="featured"  type="boolean" dbtype="boolean" required=false default=true;
}