<?php
	session_start();
	ob_implicit_flush(true); 
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->
	<style type="text/css">
		html,
		body {
		background-color: transparent;
		background-image: none;
		bgcolor="transparent"> 
		}

	</style>
</head>
<body>
	<div class="shadow10_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
				<p class="text_3">

<?php
	//
	// main script file that will output some things
	//
	require_once('ccshop.inc.php'); 
	require_once('store.inc.php');
	require_once('dbinfo.inc.php');

	// need to call function so after it returns heml text at end of file will be shown
	main_make_purchase();
	echo "<br>";
	echo "<br>";

function getParam($name)
{
	$var = $_POST[$name];
	if(!isset($var))
		die('-');
	return $var;
}

function main_make_purchase()
{
	global $conn;

	require_once('cccountries.inc.php');
	if(!cc_is_country_allowed())
		die("country not allowed for credit card use");

	$itemid = getParam('itemid');
	list($chargetotal, $x_desc) = store_GetItemPriceDescByCode($itemid, 0);

	// avoid reloading of this page
	if(!isset($_SESSION['CCPurchaseInProcess']))
	{
		echo "<strong>Please do not reload this page</strong>";
		return;
	}
	unset($_SESSION['CCPurchaseInProcess']);

	//
	// check if user can make transaction
	//

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION_CHECK ?, ?";
	$params = array($userid, 0);
	$member = db_exec($conn, $tsql, $params);

	if($member['Blocked'] > 0)
	{
		die("fraud");
	}

	echo "Processing transaction.<br><br><br>";
	//do not press any keys or back button to avoid double charges....

	$ans = issue_transaction($chargetotal);

	// check result and display errors (if any)	
	if(! check_transaction_answer($ans))
		return;

	// at this time we have successful transaction

	echo "<strong>Thank you for placing your order !</strong><br><br>";
	echo "Your Receipt<br>";

	$userid = getParam('userid');
	$bname = getParam('bname');
	$baddr1 = getParam('baddr1');
	$bcity = getParam('bcity');
	$bzip = getParam('bzip');
	$bstate = getParam('bstate');
	$bcountry = getParam('bcountry');
	if($bcountry != "US") $bstate = "";

	$cctype = getParam('cctype');
	$cardnumber = getParam('cardnumber');
	$expmonth = getParam('expmonth');
	$expyear = getParam('expyear');

	$ccn1 = substr($cardnumber, -4, 4);
	$x_payment = "$cctype ending in $ccn1<br>Expires $expmonth/$expyear";
	$x_addr    = "$bname ($userid)<br>$baddr1<br>$bcity<br>$bstate $bzip<br>$bcountry<br>";
	$x_email   = getParam('x_email');

	echo "<br>
	Order Number:  $ans->OrderId<br>
	Time:   $ans->TransactionTime <br>
	Payment Method: $x_payment<br><br>
	Billing Address:<br>
	$x_addr";

	echo "<br>
	Item:       $x_desc<br>
	Price:      $$chargetotal<br>
	Taxes:	    $0.00<br>
	Total:      $$chargetotal<br>
	<br>";

	// send confirmation email
	$email = urldecode($_POST["x_email"]);
	send_payment_email(
		$email, 
		$ans->OrderId, 		// -OID-  - order number
		$ans->TransactionTime, 	// -DT- date time
		$x_payment,	// -PAYM- - payment method
		$x_addr,	// -BILLINFO- - billing info
		$x_desc,	// -ITEM-  - item description
		$chargetotal,	// -PRICE- 
		true);
}

function check_transaction_answer($ans)
{
	$rc  = $ans->ReturnCode;
	if($rc == "0")
		return true;

	if($rc == "1")
	{
		// transaction declined;
		echo "<strong>Transaction declined!</strong><br>";
		echo "Status:  " . $ans->TransactionResult . "<br>";
		echo "Message: " . $ans->ErrorMessage . "<br>";
		echo "<br>";
		//echo "If you feel this is an error, please contact support@thewarinc.com";
		echo "Note for our international customers: If you'll get fraud decline, please try again in few days - we're investigating why that is happening";

		report_blocked_transaction();
		return false;
	}

	if($rc == "2")
	{
		// declined by CCV code
		echo "<strong>CCV code was not verified, transaction could not be processed</strong><br><br>";

		echo "Message: " . $ans->ErrorMessage . "<br>";

		report_blocked_transaction();
		return false;
	}

	if($rc == "3")
	{
		// game DB was down at the moment of transaction
		echo "<strong>There was error on our end, please contact support@thewarinc.com</strong><br><br>";
		echo "<strong>Please include OrderID " . $ans->OrderId . "</strong><br><br>";
		return false;
	}

	echo "<strong>Gateway error</strong><br><br>";
	echo "Code: $rc, Message: $ans->ErrorMessage<br>";
	//var_dump($ans);

	return false;
}

function issue_transaction($chargetotal)
{
	// create post parameters for our gateway
	$post_data['userid']     = getParam('userid');
	$post_data['itemid']     = getParam('itemid');
	$post_data['bname']      = getParam('bname');
	$post_data['baddr1']     = getParam('baddr1');
	$post_data['bcity']      = getParam('bcity');
	$post_data['bzip']       = getParam('bzip');
	$post_data['bstate']     = getParam('bstate');
	$post_data['bcountry']   = getParam('bcountry');
	$post_data['cardnumber'] = getParam('cardnumber');
	$post_data['expmonth']   = getParam('expmonth');
	$post_data['expyear']    = getParam('expyear');
	$post_data['cvm']        = getParam('cvm');
	$post_data['chargeCents']= (int)($chargetotal * 100);
	$post_data['uip']        = $_SERVER['REMOTE_ADDR'];

	//traverse array and prepare data for posting (key1=value1)
	$post_items = array();
	foreach($post_data as $key => $value) {
		$post_items[] = urlencode($key) . '=' . urlencode($value);
	}

	// exec curl
	$ch = curl_init("https://api1.thewarinc.com/payments/MakeTransaction.aspx");
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, implode('&', $post_items));
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

	$ans  = curl_exec($ch);
	if($ans === false)
	{
		echo "Curl error: " . curl_error($ch);
		die();
	}

	$json = json_decode($ans);
	return $json;
}

function report_blocked_transaction()
{
	global $conn;

	$userid = $_POST["userid"];
	if(!isset($userid) || $userid == 0)
		$userid = 0;

	// create & execute query - set user blocked status
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION_CHECK ?, ?";
	$params = array($userid, 1);
	$member = db_exec($conn, $tsql, $params);
}

?>

				</p>
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_8"></div></div>
	</div>	
</body>
</html>
