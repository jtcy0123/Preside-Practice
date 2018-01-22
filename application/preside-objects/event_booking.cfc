component dataManagerGroup="lookup" {

	property name="firstname"       type="string"  dbtype="varchar"                      ;
    property name="lastname"        type="string"  dbtype="varchar"                      ;
    property name="email"           type="string"  dbtype="varchar"                      ;

    property name="num_of_seats"    type="numeric" dbtype="integer"                      ;
    property name="total_amount"    type="numeric" dbtype="double"                       ;
    property name="special_request" type="string"  dbtype="varchar"                      ;

    property name="purchaseNum"     type="string"  dbtype="varchar"                      ;
    property name="creditCardNum"   type="string"  dbtype="varchar"                      ;
    property name="expiredDate"     type="date"    dbtype="datetime"                     ;

    property name="sessions"        relationship="many-to-many" relatedTo="session"      ;
    property name="event_detail"    relationship="many-to-one"  relatedTo="event_detail" ;
}