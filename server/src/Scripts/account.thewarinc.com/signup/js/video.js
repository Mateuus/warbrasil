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


$(document).ready(function(){

	$('#VideoOverlay').click(function () {
	
		HideVideo();
		
	});
	


});





