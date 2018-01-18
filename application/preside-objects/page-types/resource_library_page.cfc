/**
 * @searchEnabled true
 */
component  {
	property name="region" relationship="many-to-many" relatedTo="region"   ;
	property name="category" relationship="many-to-many" relatedTo="category" ;
}