/**
 * @allowedParentPageTypes event_listing
 * @allowedChildPageTypes none
 */

component  {
	property name="startdate" type="date" dbtype="datetime" required="true";
	property name="enddate"   type="date" dbtype="datetime" required="true";

	property name="regions"    relationship="many-to-many" relatedTo="region";
	property name="category"   relationship="many-to-one"  relatedTo="category";
	property name="programmes" relationship="one-to-many"  relatedTo="programme" relationshipkey="event_detail";
}