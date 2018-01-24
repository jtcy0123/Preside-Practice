$(function() {
    if( cfrequest ) {
	    var seats = $('#num_of_seats');

		seats.change(function() {
			var price = (this.value * cfrequest.eventPrice ).toFixed(2);
			$("#showTotalAmount").html(price);
		});
	}
})