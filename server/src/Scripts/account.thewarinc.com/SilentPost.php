<?php
	require_once('ccshop.inc.php');
	require_once('store.inc.php');

	// check secret code
	$x_vfcode = $_POST['x_vfcode'];
	if($x_vfcode != $SHOP_URL_VFCODE)
	{
		echo "Fraudlent usage detected<br>";
		exit();
	}

function process_auth()
{
	// response fields indicating status of transaction
	$approval_code = $_POST["approval_code"];
	$status        = $_POST["status"];
	$oid           = $_POST["oid"];

	// get cvv/avs codes from approval code
	$check_code = get_result_from_code($approval_code);

	if(!check_ccv_code($check_code))
	{
		echo "<strong>CVV code was not verified, transaction could not be processed</strong><br><br>";
//		echo "ACode:  $approval_code<br>";
//		echo "OID:    $oid<br>";

		report_blocked_transaction();
		return;
	}

	if(!check_avs_code($check_code))
	{
		echo "<strong>Address was not verified</strong>";
	}

	// ok, we have valid transaction.
	echo "Processing transaction<br><br>";

	// make postauth transaction
	$post_data['txntype']     = 'postauth';
	$post_data['oid']         = $oid;
	// add passed params as well
	$post_data['chargetotal'] = $_POST["chargetotal"];
	$post_data['userid']      = $_POST["userid"];
	$post_data['itemid']      = $_POST["itemid"];
	$post_data['x_payment']   = urldecode($_POST["x_payment"]);
	$post_data['x_addr']      = urldecode($_POST["x_addr"]);
	$post_data['x_aprcode']   = $approval_code;
	$post_data['x_email']     = urldecode($_POST["x_email"]);
	$post_data['x_ccshort']   = $_POST["x_ccshort"];

	exec_shop_call($post_data);
	exit();
}

function process_payment()
{
	// response fields indicating status of transaction
	$approval_code = $_POST["approval_code"];
	$status = $_POST["status"];
	$oid = $_POST["oid"];
	$ttime = $_POST["ttime"];

	// our fields
	$chargetotal = (float)$_POST["chargetotal"];
	$userid = $_POST["userid"];
	$itemid = $_POST["itemid"];
	$x_payment = urldecode($_POST["x_payment"]);
	$x_addr    = urldecode($_POST["x_addr"]);
	$x_aprcode = $_POST["x_aprcode"];

	$x_ccshort = $_POST["x_ccshort"];
	if(!isset($x_ccshort)) $x_ccshort = "";

	$x_desc    = store_GetItemDesc($itemid);

	// get cvv/avs codes from approval code
	$check_code = get_result_from_code($x_aprcode);
	if(!check_avs_code($check_code))
	{
		echo "<strong>Please note that credit card address was not verified</strong><br>";
	}

	echo "Thank you for placing your order !<br><br>";
	echo "Your Receipt<br><br>";

//	UserID:	$userid <br>
	echo "
	<br>
	Order Number:  $oid<br>
	Time:   $ttime <br>
	$x_desc <br>
	Payment Method - $x_payment<br><br>
	Billing Address<br>
	$x_addr";

	echo "<br>
	Item:       $x_desc<br>
	Price:      $$chargetotal<br>
	Taxes:	    $0.00<br>
	Total:      $$chargetotal<br>
	<br>
	<br>";

//	echo "Transaction details<br>";
//	echo "Status: '$status'<br>";
//	echo "ACode1: '$approval_code'<br>";
//	echo "ACode2: '$x_aprcode'<br>";

	require_once('dbinfo.inc.php');

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION ?, ?, ?, ?, ?, ?, ?, ?";
	$params = array(
		$x_ccshort . " " . $oid, 
		$userid, 
		$ttime, 
		$chargetotal, 
		$x_aprcode,
		$status, 
		$itemid, 
		'SJFei937cjsjf029sdkWccYY9');
	$member = db_exec($conn, $tsql, $params);

	// matomy
	require_once('matomy.inc.php');
	$geoIpCode = matomy_get_geoIpCode();
	matomy_do_conversion($conn, $userid, $geoIpCode, $itemid, $chargetotal, $oid);

	// send confirmation email
	$email = urldecode($_POST["x_email"]);
	send_payment_email(
		$email, 
		$oid, 		// -OID-  - order number
		$ttime, 	// -DT- date time
		$x_payment,	// -PAYM- - payment method
		$x_addr,	// -BILLINFO- - billing info
		$x_desc,	// -ITEM-  - item description
		$chargetotal,	// -PRICE- 
		true);

	return;
}

function report_blocked_transaction()
{
	$userid = $_POST["userid"];
	if(!isset($userid) || $userid == 0)
		$userid = 0;

	require_once('dbinfo.inc.php');

	// create & execute query - set user blocked status
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION_CHECK ?, ?";
	$params = array($userid, 1);
	$member = db_exec($conn, $tsql, $params);
}

?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />  
<title>Processing Transaction</title>
</head>
<body style="background-color: transparent; color: #FFFFFF;">

<?php
// check if transaction was approved
	$status     = $_POST["status"];
	$failReason = $_POST["failReason"];
	if($status != "APPROVED")
	{
  		echo "<br><br>";
		echo "Transaction declined!<br>";
		echo "Error: '$failReason'<br><br>";

		report_blocked_transaction();
		exit();
	}

// check if we was preauthorizing
	$x_auth = $_POST['x_auth'];
	if($x_auth == 1)
	{
		process_auth();
	}
	else
	{
  		process_payment();
	}
?> 
</body>
</html>

<?php

  //
  //
  // logic functions
  //
  //
 
  function get_result_from_code($approval_code)
  {
    $appfields = explode(':', $approval_code);
    if(strlen($appfields[2]) != 4) {
      echo "Gateway Error: bad AVS code returned<br>$appfields[2]";
      die();
    }

    return $appfields[2];
  }

  function check_avs_code($middle_code)
  {
    $avs_code1 = substr($middle_code, 0, 2);
    $avs_code2 = substr($middle_code, 2, 1);

    /* AVS code results:
	Code	Visa	MC	Discov	AmEx	Description
	YY	Y	Y	A	Y	Address and zip code match.
	NY	Z	Z	Z	Z	Only the zip code matches
	YN	A	A	Y	A	Only the address matches.
	NN	N	N	N	N	Neither the address nor the zip code match.
	XX	-	W			Card number not on file.
	XX	U	U	U	U	Address information not verified for domestic transaction
	XX	R	-	R	R	Retry - system unavailable.
	XX	S	-	S	S	Service not supported
	XX	E	-			AVS not allowed for card type.
	XX		-			Address verification has been requested, but not received.
	XX	G	-			Global non-AVS participantS Normally an nternational transaction.
	YN	B	-			Street address matches for international transaction. Postal code not verified.
	NN	C	-			Street address and Postal code not verified for international transaction.
	YY	D	-			Street address and Postal code match for international transaction
	YY	F	-			Street address and Postal code match for international transaction. (UK Only)
    */

    if($avs_code1 == 'YY')
      return true;

    return false;
  }

  function check_ccv_code($middle_code)
  {
    $ccv_code = substr($middle_code, 3, 1);

    /* CCV Code results:
	'M' - card number matches
	'N' - card number does not match
	'P' - not processed
	'S' - merchant has indicated that the card code is not present on the card
	'X' - no response from the credit card association was received
    */

    if($ccv_code == 'M' || $ccv_code == 'S')
      return true;

    return false;
  }

  function is_valid_referrer($url)
  {
    //if ($s1  != "https://www.linkpointcentral.com/lpc/servlet/lppay" )

    if($url == 'https://account.thewarinc.com/gen-x-2948250-UID23920.php')
      return true;

    if($url == 'https://account.thewarinc.com/ccpost.php')
      return true;

    if($url == 'http://account.thewarinc.com/ccpost.php')
      return true;

    return false;
  }

?>