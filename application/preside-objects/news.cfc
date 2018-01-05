component dataManagerGroup="lookup" {
	property name="published_date" type="date"   dbtype="datetime";
	property name="slug"           type="string" dbtype="varchar" maxLength="50" uniqueindexes="slug|2" format="slug";
	property name="content"        type="string" dbtype="text";
}