/**
 * @allowedChildPageTypes event_detail
 */

component  {
	property name="featured_event" relationship="many-to-many" relatedTo="event_detail";
	property name="region"		   relationship="many-to-one"	 relatedTo="region";
	property name="categories"	   relationship="many-to-many" relatedTo="category";
}