<?php
	//$AMAZON_ARN = "arn:aws:sns:us-east-1:222383862245:responseWarInc";
	$AMAZON_ARN = "arn:aws:sns:us-east-1:326161783280:responseWarInc";

	require_once('sdk-1.5.4/sdk.class.php');
	require_once('../dbinfo.inc.php');

	session_start();
	unset($_SESSION['amazon-login-error']);
	
	$username  = $_POST["username"];
	$password  = $_POST["password"];
	
	$requestId = $_SESSION["requestId"];
	if(!isset($requestId) || strlen($requestId) < 2)
		die('no requestid');
		
	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_LOGIN ?, ?, ?";
	$params = array($username, $password, $Last_IP);
	$member = db_exec($conn, $tsql, $params);

	$CustomerID = $member['CustomerID'];
	$AccountStatus = $member['AccountStatus'];
	if($CustomerID < 1)
	{
		if($AccountStatus >= 200) 
		{
			$_SESSION['amazon-login-error'] = "Account is frozen";
		}
		else
		{
			$_SESSION['amazon-login-error'] = "login failed";
		}
		header("location: amazon-login.php");
		exit();
	}

	$AccountName = $member["AccountName"];

	// create SNS response to amazon

	$linkAddr[0] = array(
		'Address' => (string)$CustomerID, // MUST be converted to string
		'AddressDescription' => $AccountName
		);
	$linkAns  = array(
		'Type' => 'LinkAccount',
		'RequestToken' => $requestId,
		'AccountToken' => (string)$CustomerID,
		'Kind' => 'LOGIN',
		'Addresses' => $linkAddr
		);
	$linkJson = json_encode($linkAns);

	// create SNS client and disable SSL verification.
	$sns  = new AmazonSNS();
	$sns->ssl_verification = false;
	
	$resp = $sns->publish($AMAZON_ARN, $linkJson);
        if(!$resp->isOK())
	{
		echo("There was a error communicating with Amazon, please try again later");
		exit();
	}

	if(false)
	{
		// some debug stuff

		echo("SNS Sent:<br>");
		echo("$linkJson");
		echo("<br>");
		echo("<br>");
	
		echo("Response body:<br>");
		var_dump($resp->body); echo("<br>");
		echo("<br>Response header:<br>");
		var_dump($resp->header); 
		//echo("<br>Response status:<br>");
		//var_dump($resp->status); echo("<br>");

		exit();
	}
	
	header("Location: amazon-login-success.php");
	exit();
?>