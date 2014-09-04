<?php
// This is the return URL in the SetExpressCheckout API call.
// The PayPal website redirects the user to this page with a token.

	require_once('ppaypal.inc.php');
	require_once('store.inc.php');

	// Obtain the token from PayPal.
	if(!array_key_exists('token', $_REQUEST)) {
		exit('Token is not received.');
	}

	// connect to DB *right now* - before accepting payment
	include("dbinfo.inc.php");

//
// GetExpressCheckoutDetail
//

	// Add request-specific fields to the request string.
	$nvpStr  = "";
	$nvpStr .= "&TOKEN=" . urlencode(htmlspecialchars($_REQUEST['token']));

	// Execute the API operation
	$httpParsedResponseAr = PPHttpPost('GetExpressCheckoutDetails', $nvpStr);
	$ack = strtoupper($httpParsedResponseAr["ACK"]);
	if($ack != "SUCCESS" && $ack != "SUCCESSWITHWARNING") 
	{
		exit('GetExpressCheckoutDetails failed: ' . urldecode(print_r($httpParsedResponseAr, true)));
	}

	// Extract the response details.
	$payerID    = $httpParsedResponseAr['PAYERID'];
	$token      = $httpParsedResponseAr['TOKEN'];

	$custom     = urldecode($httpParsedResponseAr['PAYMENTREQUEST_0_CUSTOM']);
	$arr_custom = explode(":", $custom);

	$itemName   = urldecode($httpParsedResponseAr['L_PAYMENTREQUEST_0_NAME0']);
	$itemCode   = $arr_custom[0];
	$itemPrice  = $arr_custom[1];
	$CustomerID = $arr_custom[2];
	$email      = $arr_custom[3];
	$geoIpCode  = $arr_custom[4];

	/*
	echo "custom:   $custom <br>";
	echo "itemName: $itemName <br>";
	echo "itemCode: $itemCode <br>";
	echo "itemPrice: $itemPrice <br>";
	echo "CustomerID: $CustomerID <br>";
	exit('Get Express Checkout Details Completed Successfully: ' . urldecode(print_r($httpParsedResponseAr, true)));
	*/

	if(!isset($itemName)) die('d1');
	if(!isset($itemCode)) die('d2');
	if(!isset($itemPrice)) die('d3');
	if(!isset($CustomerID)) die('d4');
	if(!isset($email)) die('d5');

//
// DoExpressCheckoutPayment
//

	// Add request-specific fields to the request string.
	$nvpStr  = PPAddNVPItem($itemName, $itemPrice, $custom);
	$nvpStr .= "&TOKEN="         . $token;
	$nvpStr .= "&PAYERID="       . $payerID;
	$nvpStr .= "&PAYMENTACTION=" . "Sale";

	//  Complete an Express Checkout transaction. 
	$httpParsedResponseAr = PPHttpPost('DoExpressCheckoutPayment', $nvpStr);

	$ack = strtoupper($httpParsedResponseAr["ACK"]);
	if($ack != "SUCCESS" && $ack != "SUCCESSWITHWARNING") 
	{
		exit('DoExpressCheckoutDetails failed: ' . urldecode(print_r($httpParsedResponseAr, true)));
	}

	//exit('Express Checkout Payment Completed Successfully: ' . urldecode(print_r($httpParsedResponseAr, true)));

	//
	// check if payment was successful
	//

	$PaymentStatus = urldecode($httpParsedResponseAr['PAYMENTINFO_0_PAYMENTSTATUS']);
	if(strtoupper($PaymentStatus) != "COMPLETED")
	{
		echo("There was error in your payment: $PaymentStatus<br><br>");
		echo("Please include following information and e-mail it to support@thewarinc.com<br>");
		echo(urldecode(print_r($httpParsedResponseAr, true)));
		exit();
	}

	$oid   = urldecode($httpParsedResponseAr['PAYMENTINFO_0_TRANSACTIONID']);
	//$ttime = urldecode($httpParsedResponseAr['PAYMENTINFO_0_ORDERTIME']);
	$ttime = date('Y-m-d H:i:s');

//
// Ok, finalize payment in DB
//

	echo "Thank you for placing your order !<br><br>";
	echo "Your Receipt<br><br>";

	echo "
	UserID:	$CustomerID <br>
	<br>
	PayPal Order Number:  $oid<br>
	Time:   $ttime <br>";

	echo "<br>
	Item:       $itemName<br>
	Price:      $$itemPrice<br>
	Taxes:	    $0.00<br>
	Total:      $$itemPrice<br>
	<br>
	<br>";

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION ?, ?, ?, ?, ?, ?, ?, ?";
	$params = array(
		$oid,
		$CustomerID,
		$ttime, 
		$itemPrice, 
		"PAYPAL",
		"APPROVED",
		$itemCode, 
		'SJFei937cjsjf029sdkWccYY9');
	$member = db_exec($conn, $tsql, $params);


	// notify matomy about transaction
	require_once('matomy.inc.php');
	matomy_do_conversion($conn, $CustomerID, $geoIpCode, $itemCode, $itemPrice, $oid);


	// send confirmation email
	send_payment_email(
		$email, 
		$oid, 		// -OID-  - order number
		$ttime,		// -DT- date time
		"PAYPAL",	// -PAYM- - payment method
		"",		// -BILLINFO- - billing info
		$itemName,	// -ITEM-  - item description
		$itemPrice,	// -PRICE- 
		true);

	echo "<br><br>";
	echo "<a href=\"Store.php\">Back to Store</a><br>";

	exit();
?>