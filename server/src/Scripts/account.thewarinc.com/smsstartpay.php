<?php
	session_start();
	require_once('auth.php'); 
	require_once('Store.inc.php');

	// get
	$CustomerID    = $_SESSION['CustomerID'];
	$itemCode      = $_REQUEST['ItemID'];
	if(!isset($CustomerID)) die('2');
	if(!isset($itemCode)) die('3');

	// price & description
	list($itemPrice, $itemName) = store_GetItemPriceDescByCode($itemCode, 2);
	if($itemPrice < 0)
		die('itemprice');

	// get customer email
	require_once('dbinfo.inc.php');
	$tsql   = "SELECT * FROM AccountInfo WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);
	$CustomerEmail=trim($member['email']);

	// get country geo-ip code
	require_once('matomy.inc.php');
	$geoIpCode = matomy_get_geoIpCode();

	// assemble pass-thru param
	$param    = "$CustomerID:$itemCode:$itemPrice:$CustomerEmail:$geoIpCode";

//
//  Exec BOKU prepare call
//
	$url  = "https://api2.boku.com/billing/request?action=prepare";
	$url .= "&merchant-id=arktosgroup";
	$url .= "&password=f1gz45hd5";
	$url .= "&service-id=6dfb7ffc7a8c4f6724a3777d";
	$url .= "&row-ref=$itemPrice";
	$url .= "&desc=" . urlencode($itemName);
	$url .= "&param=$param";

	// setting the curl parameters.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_VERBOSE, 1);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_POST, 0);

	// Get response from the server.
	$resp = curl_exec($ch);
	if(!$resp) {
		exit('SMS prepare failed: '.curl_error($ch).'('.curl_errno($ch).')');
	}

	// parse returned XML
	$xml_obj = simplexml_load_string($resp);
	$xml     = object2array($xml_obj);

	if($xml["result-code"] != 0)
	{
		echo "There was a error initiating SMS payment<br>";
		echo $xml["result-code"] . "<br>";
		echo $xml["result-msg"]  . "<br>";
		exit();
	}

	// redirect to buying URL
	$buyUrl = $xml['buy-url'];
	header("location: $buyUrl");
	exit();

function object2array($object) 
{ 
	return @json_decode(@json_encode($object),1); 
}

?>