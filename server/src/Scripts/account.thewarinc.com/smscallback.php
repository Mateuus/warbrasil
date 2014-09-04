<?php
	// store passed data for future use
	require_once('dbinfo.inc.php');
	require_once('store.inc.php');

	dump_sms_log($_SERVER['REQUEST_URI']);

	$action     = $_REQUEST['action'];
	$resultCode = $_REQUEST['result-code'];
	$trxid      = $_REQUEST['trx-id'];
	if(! $action) die('1');
	if(! $trxid) die('2');

	// validate signature
	if(!check_data_signature())
	{
		// 28 Invalid signature Use when the signature validation step fails.
		send_boku_ack(28, "Invalid signature");

		dump_sms_log("BAD SIGNATURE");
		exit();
	}

	// extract data from our pass-thru parameter
	$param      = urldecode($_REQUEST['param']);
	if(! $param) die('3');
	$arr_custom = explode(":", $param);
	$CustomerID = $arr_custom[0];
	$itemCode   = $arr_custom[1];
	$itemPrice  = $arr_custom[2];
	$email      = $arr_custom[3];
	$geoIpCode  = $arr_custom[4];

	// allow test transactions only for devs
	if(isset($_REQUEST['test']) && $_REQUEST['test'] == 1)
	{
		if($CustomerID != 1282052887 && $CustomerID != 1000)
		{
			send_boku_ack(0, "OK");
			exit();
		}
	}

	// get current time in LA
	date_default_timezone_set("America/Los_Angeles");
	$ttime = date('Y-m-d H:i:s');

	if($action == "event")
	{
		//@ EVENT is NOT supported yet
		dump_sms_log("event $CustomerID:$itemCode:$email");

		send_boku_ack(0, "OK");
		exit();
	}

	if($action == "billingresult")
	{
		/* 
		7 Anti-Fraud - Transaction rejected 
		  In certain cases, anti-fraud limits may result in a
		  transaction failing as part-paid. You should fulfill a prorata
		  amount of credit based on the amount paid. 
		9 Part Paid - Expired without completing
		  You should fulfill a pro-rata amount of credit based on
		  the amount paid.
		10 Part Paid - Cancelled by user
		  You should fulfill a pro-rata amount of credit based on
		  the amount paid.
		*/
		if($resultCode != 0)
		{
			send_boku_ack(0, "OK");

			dump_sms_log("billingresult FAIL $resultCode $CustomerID:$itemCode:$email:$priceNet:$trxid:$mobileNum");

			/*
			// send confirmation email with $show_success_msg=false
			send_payment_email(
				$email, 
				$trxid, 	// -OID-  - order number
				$ttime,		// -DT- date time
				"FAILED SMS",	// -PAYM- - payment method
				"payment FAILED with code $resultCode for $mobileNum",	// -BILLINFO- - billing info
				$itemCode,	// -ITEM-  - item description
				0.0,		// -PRICE- 
				false);
			*/
			exit();
		}

		$currency   = $_REQUEST['currency'];
		$pricePaid  = $_REQUEST['paid'];
		$pricePaid  = $pricePaid / 100.0;
		$priceNet   = $_REQUEST['reference-receivable-net'];
		$priceNet   = $priceNet / 100.0;

		$mobileNum  = $_REQUEST['encoded-mobile'];
		$mobileNum  = urldecode($mobileNum);

		dump_sms_log("billingresult OK $CustomerID:$itemCode:$email:$priceNet:$trxid:$mobileNum");

		// create & execute query
		$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION ?, ?, ?, ?, ?, ?, ?, ?";
		$params = array(
			$trxid,
			$CustomerID,
			$ttime,
			$priceNet,
			"SMS:$pricePaid$currency:$mobileNum",
			"APPROVED",
			$itemCode,
			'SJFei937cjsjf029sdkWccYY9');
		$member = db_exec($conn, $tsql, $params);

		// notify matomy about transaction
		require_once('matomy.inc.php');
		matomy_do_conversion($conn, $CustomerID, $geoIpCode, $itemCode, $priceNet, $trxid);

		// send confirmation email with $show_success_msg=false
		$x_desc = store_GetItemDesc($itemCode);
		send_payment_email(
			$email, 
			$trxid, 	// -OID-  - order number
			$ttime,		// -DT- date time
			"SMS",		// -PAYM- - payment method
			"$mobileNum",	// -BILLINFO- - billing info
			$x_desc,	// -ITEM-  - item description
			"$currency $pricePaid",	// -PRICE- 
			false);
	}

//
// ACK boku
//
	send_boku_ack(0, "OK");
	exit();

function dump_sms_log($msg)
{
	global $conn;

	// create & execute query
	$tsql   = "insert into DBG_SMSCallbacks (data) values (?)";
	$params = array($msg);
	$member = db_exec($conn, $tsql, $params);
}

function send_boku_ack($code, $msg)
{
	global $trxid;

	$eventcode = 0;
	if($action == "event") {
		$eventcode = $_REQUEST['event-code'];
	}

	echo "<?xml version='1.0' encoding='ISO-8859-1' ?>\n";
	echo "<callback-ack>\n";
	echo "<trx-id>$trxid</trx-id>\n";
	if($action == "event") {
		echo "<event-code>$eventcode</event-code>\n";
	}
	echo "<status code=\"$code\">$msg</status>\n";
	echo "</callback-ack>";
}

function check_data_signature()
{
	// 1. This is url checking function, as described in 
	// BOKU Security Implementation Guide • Page 11 of 17
	$BOKU_SEC_KEY = "xZ6DcdguHHFKsi8wHk9yROvOOpLeJC8Vr3CLAnUSCcBylA04uHANInUZCPmjX1eKCNb8TdX0Wm41wKOY8CocufWwGWLLTohiZrCA";

	$keys = array_keys($_GET);
	sort($keys);
	$hash_input = '';
	foreach($keys as $key) 
	{
		if($key == "sig")
			continue;

		$hash_input .= $key . urldecode($_GET[$key]);
	}
    	$hash = md5($hash_input . "$BOKU_SEC_KEY");

	$sig = urldecode($_GET["sig"]);
	if($sig != $hash)
		return false;

	return true;
}

?>