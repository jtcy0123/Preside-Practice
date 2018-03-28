/**
 *  @dataManagerGroup      lookup
 *  @datamanagerGridFields label,slug,is_primary
 */

component  {
	property name="slug"       type="string"  dbtype="varchar" default="" required=true basedOn="label" control="autoslug" uniqueindexes="tagslug";
	property name="is_primary" type="boolean" dbtype="boolean" required="false";
}

public string function createSlug( required struct orgData ) {
	var slug      = LCase( ReReplace( arguments.orgData.label, "\W", "-", "all" ) );
	var increment = 0;
	while( this.dataExists( filter={ slug = slug } ) ) {
		slug = ReReplace( slug, "\-[0-9]+$", "" ) & "-" & ++increment;
	}
	return slug;
}