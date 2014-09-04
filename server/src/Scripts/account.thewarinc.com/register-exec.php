<?php
	require_once('geo_redir.php'); 

	//Start session	
	session_start();

	// force logout current user
	unset($_SESSION['CustomerID']);
	unset($_SESSION['AccountName']);
	
	//Array to store validation errors
	$errmsg_arr = array();
	
	//Validation error flag
	$errflag = false;

	//Connect to sql server
	require_once('dbinfo.inc.php');
	
	$username   = $_POST["username"];
	$password   = $_POST["password"];
	$cpassword  = $_POST["cpassword"];
	$email      = $_POST["email"];
	$legal      = $_POST["legal"];

	if(isset($legal)) {
		$legal = "checked";
	}

	// parse referral id from invite key
	require_once('invitekey.inc.php');
	$inviteKey  = $_POST["inviteKey"];
	$referralId = invitekey_decode($inviteKey);
	if($referralId == 0)
		$referralId = 1288871140; //REFERID_Arktos
	// store inviteKey for future use
	$_SESSION['inviteKey']  = $inviteKey;
	

	// username validations
	if($username == '') {
		$Error_Username = 'Username missing';
		$errflag = true;
	}
	else if(strlen($username) > 16) {
		$Error_Username = 'Username must be less than 16 characters.';
		$errflag = true;
	}
	else if(strlen($username) < 4) {
		$Error_Username = 'Username too short.  Must be at least 4 characters.';
		$errflag = true;
	} else {
		$valid = preg_match('/^[a-z0-9_]+$/i', $username);
		if($valid == false) {
			$Error_Username = 'Username has illegal characters. Characters must be alpha-numeric.';
			$errflag = true;
		}
	}
	
	// password validation
	if($password == '') {
		$Error_Password = 'Password missing';
		$errflag = true;
	}
	else if(strlen($password) > 15) {
		$Error_Password = 'Password too long';
		$errflag = true;
	}
	else if(strlen($password) < 4) {
		$Error_Password = 'Password too short.  Must be at least 4 characters.';
		$errflag = true;
	}

	// confirm password validation
	if($cpassword == '') {
		$Error_Password = 'Confirm password missing';
		$errflag = true;
	}
	else if(strcmp($password, $cpassword) != 0 ) {
		$Error_Password = 'Passwords do not match';
		$errflag = true;
	}

	if($username != '' && strcmp($username, $password) == 0) {
		$Error_Password = 'Password can not be same as username';
		$errflag = true;
	}

	if($email == '') {
		$Error_Email = 'Email missing';
		$errflag = true;
	}

	
	if($legal == '') {
		$Error_Legal = 'You must agree to the terms';
		$errflag = true;
	}
	
	$_SESSION['username'] = $username;
	$_SESSION['password'] = $password;
	$_SESSION['cpassword'] = $cpassword;
	$_SESSION['email'] = $email;
	$_SESSION['legal'] = $legal;
	unset($_SESSION['Error_Username']);
	unset($_SESSION['Error_Password']);
	unset($_SESSION['Error_Email']);
	unset($_SESSION['Error_Legal']);

	
	// If there are input validations, redirect back to the registration form
	if($errflag) {
		
		if (isset($Error_Username)) {
			$_SESSION['Error_Username'] = $Error_Username;
		}
		if (isset($Error_Password)) {
			$_SESSION['Error_Password'] = $Error_Password;
		}
		if (isset($Error_Email)) {
			$_SESSION['Error_Email'] = $Error_Email;
		}
		if (isset($Error_Legal)) {
			$_SESSION['Error_Legal'] = $Error_Legal;
		}
		
		session_write_close();

		if($referralId == 1289007472) //  REFERID_AmazonD3
		{
			header("location: amazon/amazon-register.php");
			exit();
		}

		header("location: register.php");
		exit();
	}

	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	$reg_sid = "";
	if(isset($_SESSION['reg_sid']))
		$reg_sid = $_SESSION['reg_sid'];

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_CREATEACCOUNT ?, ?, ?, ?, ?, ?";
	$params = array(
			$Last_IP, 
			$username, 
			$password, 
			$email, 
			$reg_sid,
			$referralId);
	$member = db_exec($conn, $tsql, $params);

	// get and parse result codes
	//  0: ok
	//  1: username already exists
	//  2: email already exists
	//  3: invalid invite code
	//  4: invite code already used

	$ResultCode = $member['ResultCode'];
	if(!isset($ResultCode) || $ResultCode > 0)
	{
		
		if ($ResultCode == 1) {
			$_SESSION['Error_Username'] = "*username already exists";
		}
		else if ($ResultCode == 2) {
			$_SESSION['Error_Email'] = "*email already exists";
		}
		else if ($ResultCode == 3) {
			$_SESSION['Error_Legal'] = "*invalid invite code";
		}
		else if ($ResultCode == 4) {
			$_SESSION['Error_Legal'] = "*invite code already used";
		}
		
		session_write_close();

		if($referralId == 1289007472) //  REFERID_AmazonD3
		{
			header("location: amazon/amazon-register.php");
			exit();
		}

		header("location: register.php");
		exit();
	}
	


	// create session
	$_SESSION['CustomerID']  = $member['CustomerID'];
	$_SESSION['AccountName'] = $username;
	$_SESSION['username']    = $username;
	$_SESSION['password']    = $password;
	$_SESSION['reg_referralId'] = $referralId;

	// clear vars so register page will be empty
	unset($_SESSION['username']);
	unset($_SESSION['password']);
	unset($_SESSION['cpassword']);
	unset($_SESSION['email']);

/* MOVED TO WelcomePackage
	// radium one server side pixel
	if($referralId == 1288929113)  // REFERID_radone1
	{
		$url = "http://panel.gwallet.com/network-node/postback/earthlink?sid=" . $reg_sid;
		exec_curl($url);

		//$url1 = "https://api1.thewarinc.com/php/qq.php?id=" . urlencode($url);
		//exec_curl($url1);
	}
*/
		
	//send_welcome_email($email);

	regiser_user_at_forum($username, $password, $email);

	if($referralId == 1289007472) //  REFERID_AmazonD3
	{
		header("location: amazon/amazon-register-success.php");
		exit();
	}

	if($referralId == 1288871135) // REFERID_XFIRE
	{
		header("location: http://www.xfire.com/cms/warinc");
		exit();
	}

	header("location: home.php?id=1");
	exit();

	//
	// actual send function
	//

	function regiser_user_at_forum($user, $passw, $email)
	{
		$post_data['WOKey']  = 'f$4gkzkdk3zj';
		$post_data['user']   = $user;
		$post_data['passwd'] = $passw;
		$post_data['email']  = $email;

		//traverse array and prepare data for posting (key1=value1)
		$post_items = array();
		foreach ( $post_data as $key => $value) {
			$post_items[] = urlencode($key) . '=' . urlencode($value);
		}

		//create the final string to be posted using implode()
		$post_string = implode ('&', $post_items); 

		$PostURL = "http://forums.thewarinc.com/wo/wo_adduser.php";

		// exec curl
		$ch = curl_init($PostURL);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_HEADER, false);  // DO NOT RETURN HTTP HEADERS
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3");
		curl_setopt($ch, CURLOPT_AUTOREFERER, true);

		$Rec_Data = curl_exec($ch);
		//DO NOT echo "$Rec_Data";
	}

	function send_welcome_email($email)
	{
		require_once('PHPMailer_v5.1/class.phpmailer.php');

		if(!isset($email))
			die('email');

		$body             = file_get_contents("EMails\email_welcome.html");

		$mail             = new PHPMailer(true); // the true param means it will throw exceptions on errors, which we need to catch

		try {
		$mail->IsSMTP(); // telling the class to use SMTP
		$mail->SMTPDebug  = 1;  // enables SMTP debug information (for testing)
					// 1 = errors and messages
					// 2 = messages only
		$mail->SMTPAuth   = true;
		$mail->Host       = "smtp.sendgrid.net";
		$mail->Username   = "pr@arktosentertainment.com";
		$mail->Password   = "wsxmko!10";

		$mail->SetFrom('donotreply@thewarinc.com', 'War Inc. Battlezone');
		$mail->Subject    = "Welcome to War Inc Battlezone Closed Beta Test!";
		$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!";
		$mail->MsgHTML($body);
		$mail->AddAddress($email);

		$mail->Send();

		} catch (phpmailerException $e) {
			//echo "<strong>There was error sending mail to $email</strong>";
			//echo $e->errorMessage(); // Pretty error messages from PHPMailer
		} catch (Exception $e) {
			//echo "<strong>There was error sending mail to $email</strong>";
			//echo $e->getMessage(); // Boring error messages from anything else!
		}
	}

function exec_curl($url)
{
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_HEADER, false);  // DO NOT RETURN HTTP HEADERS
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

	$httpResponse = curl_exec($ch);
}

?>