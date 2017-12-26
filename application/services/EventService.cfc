component {
	/***
	*@event_detail.inject presidecms:object:event_detail
	**/

	public function init( required any event_detail ) {
		_setEventDetail(arguments.event_detail);
	}


	public function getAllEventDetail( string id="", string parentPage="", string region="", string category="" ) {

		if ( !len( arguments.parentPage & arguments.id ) ) {
			return QueryNew("");
		};

		var filter       = "DATE(event_detail.startdate) >= DATE(now())";
		var filterParams = {};

		if ( len(arguments.parentPage) ) {
			filter &= " AND page.parent_page = :page.parent_page ";
			filterParams["page.parent_page"] = arguments.parentPage
		};

		if ( len(arguments.id) ) {
			if ( len(arguments.parentPage) ) {
				filter &= " AND page.id IN ( :page.id ) ";
			} else {
				filter &= " AND page.id NOT IN ( :page.id ) ";
			}
			filterParams["page.id"] = ListToArray( arguments.id )
		};

		if (len(arguments.category) ) {
			filter &= " AND category.id = :category.id";
			filterParams["category.id"] = arguments.category;
		};

		if (len(arguments.region) ) {
			filter &= " AND region.id IN ( :region.id) ";
			filterParams["region.id"] = ListToArray( arguments.region );
		};

		return _getAllEventDetail().selectData(
			  selectFields = ["page.id", "page.title","event_detail.startdate as start","event_detail.enddate as end", "GROUP_CONCAT(regions.label) as regions", "event_detail.category as category"]
			, filter       = filter
			, filterParams = filterParams
			, saveFilters  = ["livePages"]
			, groupBy      = "event_detail.id"
		);
	}

	private function _getAllEventDetail(){
		return _eventDetail;
	}

	private function _setEventDetail( required any event_detail ) {
		return _eventDetail = arguments.event_detail;
	}
}

