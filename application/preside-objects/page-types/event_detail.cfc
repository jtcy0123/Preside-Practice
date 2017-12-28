/**
 * @showInSiteTree         false
 * @allowedParentPageTypes event_listing
 * @allowedChildPageTypes  none
 * @siteTreeGridFields     page.title,startdate,enddate,price,bookable
*/

component  {
	property name="startdate"      type="date"    dbtype="datetime"                                                     ;
	property name="enddate"        type="date"    dbtype="datetime"                                                     ;
	property name="bookable"       type="boolean" dbtype="boolean"                                                      ;
	property name="price"          type="numeric" dbtype="double"                                                       ;

	property name="document"       relationship="many-to-one"  relatedTo="asset"         allowedTypes="pdf"             ;
	property name="regions"        relationship="many-to-many" relatedTo="region"                                       ;
	property name="category"       relationship="many-to-one"  relatedTo="category"                                     ;
	property name="programmes"     relationship="one-to-many"  relatedTo="programme"     relationshipkey="event_detail" ;
	property name="sessions"       relationship="one-to-many"  relatedTo="session"       relationshipkey="event_detail" ;
	property name="event_bookings" relationship="one-to-many"  relatedTo="event_booking" relationshipkey="event_detail" ;
}