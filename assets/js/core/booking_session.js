$(function() {
    if( cfrequest ) {
	    var seats = $('num_of_seats');
		seats.onchange = function(){
			var price = (this.value * cfrequest.eventPrice ).toFixed(2);
			$("showTotalAmount").innerHTML = price;
		}
	}
});