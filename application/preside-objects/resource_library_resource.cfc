/**
 * @dataManagerGridFields title,category
 */
component {
	property name="category" relationship="many-to-one"  searchEnabled=true searchSearchable=false;
	property name="region"   relationship="many-to-many" searchEnabled=true searchSearchable=false;
}