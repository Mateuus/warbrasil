<?php
	// store passed data for future use
	require_once('dbinfo.inc.php');

	$appId   = $_REQUEST['appId'];
	$userId  = $_REQUEST['userId'];
	$amount  = $_REQUEST['amount'];
	$trackId = $_REQUEST['trackId'];
	$hash    = $_REQUEST['hash'];
	$pid     = $_REQUEST['pid'];

	// check if input is correct
	$radium_skey = "81696842d07b4748a5f22968b6a557ce";
	$my_str  = $userId . ":" . $appId . ":" . $radium_skey;
    	$my_hash = md5($my_str);
	if($hash != $my_hash) {
		die("0");
	}

	if(!isset($pid)) {
		$pid = "no pid";
	}

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_RadiumGiveBonus ?, ?, ?";
	$params = array(
		$userId,
		$amount,
		$pid);
	$member = db_exec($conn, $tsql, $params);

	echo("1");
	return;
?>