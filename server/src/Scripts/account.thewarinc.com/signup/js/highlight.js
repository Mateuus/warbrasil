function highlightPic(picName) {
	
		myPic = picName;		

		if (document.getElementById) { // DOM3 = IE5, NS6
			
			document.getElementById(myPic).style.visibility = 'visible';	

		}
		else if (document.layers) { // Netscape 4
			
			document.myPic.visibility = 'visible';

		}
		else { // IE 4
			
			document.all.myPic.style.visibility = 'visible';
			
		}
}




function unhighlightPic(picName) {

	myPic = picName;

	if (document.getElementById) { // DOM3 = IE5, NS6
		
		document.getElementById(myPic).style.visibility = 'hidden';	

	}
	else if (document.layers) { // Netscape 4
		
		document.myPic.visibility = 'hidden';

	}
	else { // IE 4
		
		document.all.myPic.style.visibility = 'hidden';
		
	}	
		
}

