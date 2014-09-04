<?php
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 
	
	require_once('store.inc.php');
	require_once('store_g1c.inc.php');

	require_once('dbinfo.inc.php');

	if(!isset($_SESSION['GamersfirstID']))
		die('fraud');

	$CustomerID = $_SESSION['CustomerID'];

	// get item price and desc
	$x_id = $_REQUEST['ItemID'];
	if(!isset($x_id))
		die('fraud');

	list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($x_id, 3);
	$g1cost = g1c_GCtoG1C($x_price);

	$transactionId = trim(com_create_guid(), "{}");
	$res = g1c_BuyItem($x_id, $g1cost, $transactionId);
	if(!$res) 
	{
		echo("<h2>");
		echo("<br><br>");
		echo("There was a error processing transaction.");
		echo("</h2>");
		return;
	}

	$ttime = date('Y-m-d H:i:s');

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION ?, ?, ?, ?, ?, ?, ?, ?";
	$params = array(
		$transactionId,
		$CustomerID,
		$ttime,
		g1c_G1CtoUSD($g1cost),
		"G1C",
		"APPROVED",
		$x_id,
		'SJFei937cjsjf029sdkWccYY9');
	$member = db_exec($conn, $tsql, $params);

	header("Location: history.php");
	return;
?>