/**
* @presideService
*/
component {
	/**
	*@event_detail.inject presidecms:object:event_detail
	*/

	public function init( required any event_detail ) {
		_setEventDetail(arguments.event_detail);
	}

	public function getAllEventDetail( string id="", string parentPage="", string region="", string category="", numeric currentPage=1, numeric maxRows=0 ) {

		if ( !len( arguments.parentPage & arguments.id ) ) {
			return QueryNew("");
		};

		var filter       = "DATE(event_detail.startdate) >= DATE(now())";
		var filterParams = {};
		var startRow 	 = ((arguments.currentPage - 1) * arguments.maxRows) + 1;

		// if ( len(arguments.parentPage) ) {
		// 	filter &= " AND page.parent_page = :page.parent_page ";
		// 	filterParams["page.parent_page"] = arguments.parentPage
		// };

		if ( len(arguments.id) ) {
			filter &= " AND page.id IN ( :page.id ) ";
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

		return _getEventDetail().selectData(
			  selectFields = ["page.id", "page.title","event_detail.startdate as start","event_detail.enddate as end", "GROUP_CONCAT(regions.label) as regions", "category.label as category"]
			, filter       = filter
			, filterParams = filterParams
			, saveFilters  = ["livePages"]
			, groupBy      = "event_detail.id"
			, orderBy      = "event_detail.startdate"
			, maxRows 	   = arguments.maxRows
			, startRow 	   = startRow
		);
	}

	public function getEventByID( id="" ) {
		return _getEventDetail().selectData(
			  selectFields = ["page.id", "page.title", "event_detail.startdate as start", "event_detail.enddate as end", "event_detail.price as price", "event_detail.total_seats", "event_detail.seats_booked"]
			, filter       = "DATE(event_detail.startdate) >= DATE(now()) AND page.id IN ( :page.id )"
			, filterParams = { "page.id" = listToArray(arguments.id) }
		);
	}

	public function getRelatedEvent( string excludeId="", string region="", string numOfEvent="5" ) {
		var filter       = "DATE(event_detail.startdate) >= DATE(now())";
		var filterParams = {};

		if ( len(arguments.excludeId) ) {
			filter &= " AND page.id NOT IN ( :page.id )";
			filterParams["page.id"] = listToArray(arguments.excludeId);
		}

		if (len(arguments.region) ) {
			filter &= " AND region.id IN ( :region.id) ";
			filterParams["region.id"] = ListToArray( arguments.region );
		};

		return _getEventDetail().selectData(
			  selectFields = ["page.id", "page.title", "event_detail.startdate as start", "event_detail.enddate as end", "GROUP_CONCAT(regions.label) as regions"]
			, filter       = filter
			, filterParams = filterParams
			, groupBy      = "event_detail.id"
			, orderBy      = "event_detail.startdate"
			, maxRows      = arguments.numOfEvent
		);
	}

	public function getExpiredEvent() {
		var filter       = "DATE(event_detail.startdate) < DATE(now())";

		return _getEventDetail().selectData(
			  selectFields = ["page.id", "page.title", "event_detail.startdate as start", "event_detail.enddate as end"]
			, filter       = filter
			, groupBy      = "event_detail.id"
			, orderBy      = "event_detail.startdate"
		);
	}

	private function _getEventDetail() {
		return _eventDetail;
	}

	private function _setEventDetail( required any event_detail ) {
		return _eventDetail = arguments.event_detail;
	}
}

