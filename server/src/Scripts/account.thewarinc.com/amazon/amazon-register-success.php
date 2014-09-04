<?php
	session_start();

	$requestId = $_SESSION["requestId"];
	if(!isset($requestId) || strlen($requestId) < 2)
		die('no requestid');

	$CustomerID = $_SESSION['CustomerID'];
	if(!isset($CustomerID))
		die('no CustomerID');

	$AccountName = $_SESSION['AccountName'];
	if(!isset($AccountName))
		die('no AccountName');


	// create SNS response to amazon

	//$AMAZON_ARN = "arn:aws:sns:us-east-1:222383862245:responseWarInc";
	$AMAZON_ARN = "arn:aws:sns:us-east-1:326161783280:responseWarInc";

	require_once('sdk-1.5.4/sdk.class.php');

	$linkAddr[0] = array(
		'Address' => (string)$CustomerID, // MUST be converted to string
		'AddressDescription' => $AccountName
		);
	$linkAns  = array(
		'Type' => 'LinkAccount',
		'RequestToken' => $requestId,
		'AccountToken' => (string)$CustomerID,
		'Kind' => 'REGISTRATION',
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

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Login</title>
</head>

<body>

<script language="javascript"> 
<!-- 
setTimeout("self.close();", 10) 
//--> 
</script>

  <h3>
    <font face="Verdana">Registration Complete!</font>
  </h3>
</body>

</html>
