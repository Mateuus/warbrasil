<?php
	$email = $_POST['email'];
	if(!isset($email) || strlen($email)<4) {
		header("location: unsubscribe.php?id=3");
		exit();
	}
	
	require_once('dbinfo.inc.php');

	// create & execute query
	$tsql   = "EXEC ECLIPSE_Unsubscribe ?";
	$params = array($email);
	$member = db_exec($conn, $tsql, $params);

	$rc=$member['ResultCode'];	
	if(!isset($rc) || $rc != 0)
	{
		header("location: unsubscribe.php?id=3");
		exit();
	}
	
	header("location: unsubscribe.php?id=1");
?>