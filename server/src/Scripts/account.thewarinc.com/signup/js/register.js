function registerAccount() {
		
	error = 0;
	
	var error_username = 0;
	var error_password = 0;
	var error_cpassword = 0;
	var error_email = 0;
	var error_legal = 0;
	
	document.getElementById('error_username').innerHTML = "";
	document.getElementById('error_password').innerHTML = "";
	document.getElementById('error_cpassword').innerHTML = "";
	document.getElementById('error_email').innerHTML = "";
	document.getElementById('error_legal').innerHTML = "";
	

	if (document.registerForm.username.value.length > 16 ) {
	
		error = 1;
		error_username = 1;
		
		document.getElementById('error_username').innerHTML = "<span class='error' >*Username must be less than 16 characters.</span>";
	}
	
	if (document.registerForm.username.value.length < 4 ) {
	
		error = 1;
		error_username = 1;
		
		document.getElementById('error_username').innerHTML = "<span class='error' >*Username too short.  Must be at least 4 characters.</span>";
	}
	
	
	if (/^[a-z0-9]+$/i.test(document.registerForm.username.value) == false ) {
	
		error = 1;
		error_username = 1;
		
		document.getElementById('error_username').innerHTML = "<span class='error' >*Username has illegal characters. Characters must be alpha-numeric.</span>";
	}
	
	if (document.registerForm.username.value == "" ) {
	
		error = 1;
		error_username = 1;
		
		document.getElementById('error_username').innerHTML = "<span class='error' >*You must enter in a username.</span>";
	}
	
	
	
	if (document.registerForm.password.value == "" ) {
	
		error = 1;
		error_password = 1;
		
		document.getElementById('error_password').innerHTML = "<span class='error' >*You must enter in an password.</span>";
	}
	
	if (document.registerForm.password.value.length > 15 ) {
	
		error = 1;
		error_password = 1;
		
		document.getElementById('error_password').innerHTML = "<span class='error' >*Password too long. Must be less than 15 characters.</span>";
	}
	
	if (document.registerForm.password.value.length < 4 ) {
	
		error = 1;
		error_password = 1;
		
		document.getElementById('error_password').innerHTML = "<span class='error' >*Password too short.  Must be at least 4 characters.</span>";
	}
	
	if (document.registerForm.password.value == "" ) {
	
		error = 1;
		error_password = 1;
		
		document.getElementById('error_password').innerHTML = "<span class='error' >*You must enter in an password.</span>";
	}
	
	
	
	if (document.registerForm.cpassword.value != document.registerForm.password.value ) {
	
		error = 1;
		error_cpassword = 1;
		
		document.getElementById('error_cpassword').innerHTML = "<span class='error' >*Passwords do not match.</span>";
	}
	
	if (document.registerForm.cpassword.value == "" ) {
	
		error = 1;
		error_cpassword = 1;
		
		document.getElementById('error_cpassword').innerHTML = "<span class='error' >*You must confirm your password.</span>";
	}
	
	if (/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/.test(document.registerForm.email.value) == false ) {
	
		error = 1;
		error_email = 1;
		
		document.getElementById('error_email').innerHTML = "<span class='error' >*Must be a valid email address.</span>";
	}
	
	if (document.registerForm.email.value == "" ) {
	
		error = 1;
		error_email = 1;
		
		document.getElementById('error_email').innerHTML = "<span class='error' >*You must enter in your email address.</span>";
	}
	
	
	if (document.registerForm.legal.checked == false ) {
	
		error = 1;
		error_legal = 1;
		
		document.getElementById('error_legal').innerHTML = "<span class='error' >*You must accept the terms.</span>";
	
	}
	
	
	
	if (error == 0) {
	
		document.registerForm.submit();
		//alert('Register Account')

	}
	else {
		
		document.getElementById('FormErrors').style.display = "block";
	}



}
	