<?php
	session_start();
	require_once('auth.php'); 
	require_once('Store.inc.php');
	require_once('dbinfo.inc.php');

	//debug $_POST['x_id'] = 'GPX4';

	// get
	$CustomerID    = $_SESSION['CustomerID'];
	$itemCode      = $_REQUEST['ItemID'];
	if(!isset($CustomerID)) die('2');
	if(!isset($itemCode)) die('3');

	// get customer email
	$tsql   = "SELECT * FROM AccountInfo WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);
	$CustomerEmail=trim($member['email']);

	// price & description
	list($itemPrice, $itemName) = store_GetItemPriceDescByCode($itemCode, 1);
	if($itemPrice < 0.01)
		die('itemprice');

	// get country geo-ip code
	require_once('matomy.inc.php');
	$geoIpCode = matomy_get_geoIpCode();

//
//  Initiate an Express Checkout transaction. 
//

	require_once('ppaypal.inc.php');

	// create custom passthru string for paypal
	$custom    = "$itemCode:$itemPrice:$CustomerID:$CustomerEmail:$geoIpCode";

	// Add request-specific fields to the request string.
	$nvpStr  = PPAddNVPItem($itemName, $itemPrice, $custom);
	$nvpStr .= "&ReturnUrl="     . urlencode("https://account.thewarinc.com/ppsuccess.php");
	$nvpStr .= "&CANCELURL="     . urlencode("https://account.thewarinc.com/store.php");
	$nvpStr .= "&PAYMENTACTION=" . "Sale";
	$nvpStr .= "&NOSHIPPING="    . "1";
	$nvpStr .= "&ALLOWNOTE="     . "0";

	$httpParsedResponseAr = PPHttpPost('SetExpressCheckout', $nvpStr);

	$ack = strtoupper($httpParsedResponseAr["ACK"]);
	if($ack != "SUCCESS" && $ack != "SUCCESSWITHWARNING") 
	{
		exit('SetExpressCheckoutDetails failed: ' . urldecode(print_r($httpParsedResponseAr, true)));
	}

	// Redirect to paypal.com.
	$token = urldecode($httpParsedResponseAr["TOKEN"]);
	$payPalURL = "https://www.paypal.com/webscr&cmd=_express-checkout&token=$token";
	if("sandbox" === $environment || "beta-sandbox" === $environment) {
		$payPalURL = "https://www.$environment.paypal.com/webscr&cmd=_express-checkout&token=$token";
	}
	header("Location: $payPalURL");
	exit();
?>