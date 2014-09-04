function ShowVideo(VideoID) {

	document.getElementById('YouTubePlayer').innerHTML = "<iframe class='youtube-player' type='text/html' width='640' height='385' src='https://www.youtube.com/embed/" + VideoID + "' frameborder='0'></iframe>";


	document.getElementById('VideoPopUp').style.display = "block";
	document.getElementById('VideoOverlay').style.display = "block";

}

function HideVideo() {

	document.getElementById('VideoPopUp').style.display = "none";
	document.getElementById('VideoOverlay').style.display = "none";
	document.getElementById('YouTubePlayer').innerHTML = "";

}


var CurrentFeature = 1;

$(document).ready(function(){

	$('#VideoOverlay').click(function () {
	
		HideVideo();
		
	});
	


	$('#gallery1 a').lightBox();
	$('#gallery2 a').lightBox();
	$('#gallery3 a').lightBox();
	
	
	//jCarousel Plugin
	$('#carousel').jcarousel({
		scroll: 4,
		auto: 0,
		wrap: 'last',
		visible: 4,
		initCallback: mycarousel_initCallback
	});
	
	//jCarousel Plugin
	$('#carousel2').jcarousel({
		scroll: 4,
		auto: 0,
		wrap: 'last',
		initCallback: mycarousel2_initCallback
	});
	
	
	
	//Front page Carousel - Initial Setup
	$('div#slideshow-carousel a img').css({'opacity': '0.5'});
	$('div#slideshow-carousel a img:first').css({'opacity': '1.0'});
	$('div#slideshow-carousel li a:first').append('<span class="arrow"></span>')
	
	$('div#slideshow-carousel2 a img').css({'opacity': '0.5'});
	$('div#slideshow-carousel2 a img:first').css({'opacity': '1.0'});
	$('div#slideshow-carousel2 li a:first').append('<span class="arrow"></span>')
	
	

	//Combine jCarousel with Image Display
	$('div#slideshow-carousel2 li a').hover(
		function () {
				
			if (!$(this).has('span').length) {
				$('div#slideshow-carousel2 li a img').stop(true, true).css({'opacity': '0.5'});
				$(this).stop(true, true).children('img').css({'opacity': '1.0'});
			}		
		},
		function () {
				
			$('div#slideshow-carousel2 li a img').stop(true, true).css({'opacity': '0.5'});
			$('div#slideshow-carousel2 li a').each(function () {

				if ($(this).has('span').length) $(this).children('img').css({'opacity': '1.0'});

			});
				
		}
	).click(function () {

			$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main2 li').removeClass('active');        
		$('div#slideshow-main2 li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	
	
	$('div#F1 a').click(function () {
	
		CurrentFeature = 1;

		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	
	$('div#F2 a').click(function () {
	
		
		CurrentFeature = 2;

		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	$('div#F3 a').click(function () {
	
		CurrentFeature = 3;

		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	$('div#F4 a').click(function () {

		
		CurrentFeature = 4;
		
		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	$('div#F5 a').click(function () {
	
		
		CurrentFeature = 5;

		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	$('div#F6 a').click(function () {

		
		CurrentFeature = 6;
		
		$('span.arrow').remove();        
		$(this).append('<span class="arrow"></span>');
		$('div#slideshow-main li').removeClass('active');        
		$('div#slideshow-main li.' + $(this).attr('rel')).addClass('active');	
			
		return false;
	});
	
	$('#RightButton').click(function () {

		CurrentFeature +=1;
		
		if (CurrentFeature > 6) {
			CurrentFeature = 1;
		}
		
		changeFeature(CurrentFeature);
		
	});
	
	$('#LeftButton').click(function () {

		CurrentFeature -=1;
		
		if (CurrentFeature < 1) {
			CurrentFeature = 6;
		}
		
		changeFeature(CurrentFeature);
		
	});
	
	
	
	


});


function changeFeature(FeatNumber) {

	var myFeat = "p" + FeatNumber;

	$('div#slideshow-main li').removeClass('active');        
	$('div#slideshow-main li.' + myFeat ).addClass('active');
	
}

	
function mycarousel_initCallback(carousel) {
	
	// Pause autoscrolling if the user moves with the cursor over the clip.
	carousel.clip.hover(function() {
		carousel.stopAuto();
	}, function() {
		carousel.startAuto();
	});
}

function mycarousel2_initCallback(carousel) {
	
	// Pause autoscrolling if the user moves with the cursor over the clip.
	carousel.clip.hover(function() {
		carousel.stopAuto();
	}, function() {
		carousel.startAuto();
	});
}




