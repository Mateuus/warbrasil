<?php
	$token = $_REQUEST['token'];
	if(!isset($token)) {
		die('no token');
	}

	$newpwd1 = $_REQUEST['newpwd1'];
	$newpwd2 = $_REQUEST['newpwd2'];
	if(strlen($newpwd1) < 4)
	{
		header("location: pwdreset2.php?id=4&token=$token");
		exit();
	}
	if($newpwd1 != $newpwd2)
	{
		header("location: pwdreset2.php?id=2&token=$token");
		exit();
	}
	
	require_once('dbinfo.inc.php');
	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	// create & execute query
	$tsql   = "EXEC ECLIPSE_PwdResetExec ?,?,?";
	$params = array($Last_IP, $token, $newpwd1);
	$member = db_exec($conn, $tsql, $params);

	$rc=$member['ResultCode'];	
	if(!isset($rc) || $rc != 0)
	{
		$msg = $member['ResultMsg'];
		die("Password Set Failed: $msg");
	}

	$email   = $member["email"];
	$accname = $member["AccountName"];

	echo "Password for account $accname was successfully changed<br>";
?>