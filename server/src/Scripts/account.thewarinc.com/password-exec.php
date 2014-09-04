<?php
	session_start();
	require_once('auth.php'); 
	require_once('dbinfo.inc.php');

	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	$passwd = $_POST["passwd"];
	$newpasswd = $_POST["newpasswd"];
	$newpasswd2 = $_POST["newpasswd2"];
	if(strlen($newpasswd) < 4)
	{
		header("location: password.php?id=4");
		exit();
	}
	if($newpasswd != $newpasswd2)
	{
		header("location: password.php?id=2");
		exit();
	}

	$CustomerID = $_SESSION['CustomerID'];	


	// create & execute query
	$tsql   = "EXEC ECLIPSE_CHANGEPASSWORD ?, ?, ?, ?";
	$params = array($Last_IP, $CustomerID, $passwd, $newpasswd);
	$member = db_exec($conn, $tsql, $params);
	if($member["ResultCode"] != 0)
	{
		header("location: password.php?id=3");
		exit();
	}	

	header("location: password.php?id=1");
?>