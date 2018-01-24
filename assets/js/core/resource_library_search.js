$(function() {
	if (cfrequest) {
		$('#filterform input').change(function() {
			$('#filterform').submit();
		});

		if ( $('#showMore') ) {
			var resultUrl  = cfrequest.resultUrl;
			var category   = cfrequest.category;
			var region     = cfrequest.region;
			var totalPages = cfrequest.totalPages;

			$('#showMore').click(function(event) {
				var nextPage = parseInt($('#currentPage').val()) + 1;
				$('#currentPage').val(nextPage);

				event.preventDefault();

				$.ajax({
					type: "GET",
					url : resultUrl,
					data: { category: category, region: region, page: nextPage},
					success: function(result) {
						$('#resourcesDiv').append(result);

						if(nextPage >= totalPages) $('#showMore').hide();
					}
				})
			});
		}
	}
});