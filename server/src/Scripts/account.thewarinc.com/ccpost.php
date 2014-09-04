<?php
require_once('ccshop.inc.php'); 
require_once('Store.inc.php');

require_once('cccountries.inc.php');
if(!cc_is_country_allowed())
	die("country not allowed for credit card use");


$chargetotal = 1.99;
$userid      = $_POST['userid'];
$itemid      = $_POST['itemid'];
if(!isset($userid))
	die("fraud1");
if(!isset($itemid))
	die("fraud2");
list($chargetotal, $Item_Desc) = store_GetItemPriceDescByCode($itemid, 0);

	//
	// check if user can make transaction
	//

	require_once('dbinfo.inc.php');

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION_CHECK ?, ?";
	$params = array($userid, 0);
	$member = db_exec($conn, $tsql, $params);

	if($member['Blocked'] > 0)
	{
		die("fraud");
	}


$bname = $_POST['bname'];
$baddr1 = $_POST['baddr1'];
$bcity = $_POST['bcity'];
$bzip = $_POST['bzip'];
$bstate = $_POST['bstate'];
$bcountry = $_POST['bcountry'];
$cctype = $_POST['cctype'];
$cardnumber = $_POST['cardnumber'];
$expmonth = $_POST['expmonth'];
$expyear = $_POST['expyear'];
$CVVCode = $_POST['cvm'];


echo "<body style=\"background-color: transparent; color: #FFFFFF;\">";

//echo "userid: " . $userid . "<br>";
//echo "itemid: " . $itemid . "<br>";
//echo "bname: " . $bname . "<br>";
//echo "baddr1: " . $baddr1 . "<br>";
//echo "bcity: " . $bcity . "<br>";
//echo "bzip: " . $bzip . "<br>";
//echo "bstate: " . $bstate . "<br>";
//echo "bcountry: " . $bcountry . "<br>";
//echo "cctype: " . $cctype . "<br>";
//echo "cardnumber: " . $cardnumber . "<br>";
//echo "expmonth: " . $expmonth . "<br>";
//echo "expyear: " . $expyear . "<br>";
//echo "CVV Code: " . $CVVCode . "<br>";

echo "<br><br><br><br>Processing transaction. do not press any keys or back button to avoid double charges....<br><br><br><br><br>";


//create array of data to be posted
$post_data['txntype'] = "preauth";
$post_data['chargetotal'] = $chargetotal;
$post_data['userid'] = $userid;
$post_data['itemid'] = $itemid;

$ccn1 = substr($cardnumber,-4,4);

$post_data['x_payment'] = "$cctype ending in $ccn1<br>Expires $expmonth/$expyear";

$post_data['x_addr'] = "$bname ($userid)<br>$baddr1<br>$bcity<br>$bstate $bzip<br>$country<br>";
$post_data['x_auth'] = 1;
$post_data['x_email'] = $_POST['x_email'];
$post_data['bname'] = $bname;
$post_data['baddr1'] = $baddr1;
$post_data['bcity'] = $bcity;
$post_data['bzip'] = $bzip;
if ($bcountry == "US")
{
  $post_data['bstate'] = $bstate;
}
else
{
 $post_data['bstate2'] = $bcountry;
}
$post_data['bcountry'] = $bcountry;
$post_data['cctype'] = $cctype;
$post_data['cardnumber'] = $cardnumber;
$post_data['expmonth'] = $expmonth;
$post_data['expyear'] = $expyear;
$post_data['cvm'] = $CVVCode;

$post_data['x_ccshort'] = substr($cardnumber, 0, 4) . ".." . substr($cardnumber, -4, 4);

exec_shop_call($post_data);
?>