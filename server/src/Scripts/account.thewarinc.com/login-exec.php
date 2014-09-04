<?php
	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$username = $_POST["username"];
	$password = $_POST["password"];
		
	if (isset($_SESSION['username']))
		$username=$_SESSION['username'];
	if (isset($_SESSION['password']))
		$password=$_SESSION['password'];

	$Last_IP = $_SERVER['REMOTE_ADDR']; 
	
	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_LOGIN ?, ?, ?";
	$params = array($username, $password, $Last_IP);
	$member = db_exec($conn, $tsql, $params);
			
	$CustomerID = $member['CustomerID'];
	$AccountStatus = $member['AccountStatus'];
	if($CustomerID < 1)
	{
		//username failed

		//Unset the variable SESS_MEMBER_ID stored in session	
		unset($_SESSION['CustomerID']);
		unset($_SESSION['AccountName']);

		session_destroy();

		if($AccountStatus >= 200) 
		{
			header("location: login-frozen.php");
			exit();
		}
		header("location: login-failed.php");
		exit();
	}

	$_SESSION['CustomerID']=$member['CustomerID'];
	$_SESSION['AccountName']=$member['AccountName'];
	$_SESSION['username']=$username;
	$_SESSION['password']=$password;

	// store gamersfirst id
	$GamersfirstID = $member['GamersfirstID'];
	if(isset($GamersfirstID) && $GamersfirstID > 0)
		$_SESSION['GamersfirstID'] = $GamersfirstID;
        
	session_regenerate_id();
	//header("location: home.php?id=1");
	
	
	if (isset($_POST['page'])) {
		$CurrentURL = $_POST['page'];
		header("location: $CurrentURL");
	}
	else {
		header("location: home.php?id=1");
	}
	
	
	sqlsrv_free_stmt($stmt);
	sqlsrv_close($conn);
?>
