	function showProgressBar(value){
		$('.progress_block .value').text(value+'%');
		$('.progres_bar').css('width', value+'%');
	}
	
	function showTime(days, hours, minutes){
  		$('.time_left .days').text(days);
  		$('.time_left .hours').text(hours);
  		$('.time_left .minutes').text(minutes);
	}
	
	$('.time_left li').each(function(indx){
		if($(this).text() == '1'){
			$(this).addClass('one');
		}
	});
