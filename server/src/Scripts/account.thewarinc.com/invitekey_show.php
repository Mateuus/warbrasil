<?php
	require_once('invitekey.inc.php');

	//Connect to sql server
	require_once('dbinfo.inc.php');

	$AccountName = $_REQUEST['id'];
	if(isset($AccountName))
	{
		// create & execute query
		$tsql   = "SELECT CustomerID from LoginID where AccountName=?";
		$params = array($AccountName);
		$member = db_exec($conn, $tsql, $params);
		
		$CustomerID = $member['CustomerID'];

		if(!isset($CustomerID))	{
			die("there is no account: $AccountName");
		}

		// parse referral id from invite key
		$InviteKey = invitekey_encode($CustomerID);

		$MyReferralLink = "http://signup.thewarinc.com/?id=" . $InviteKey;
		echo("$AccountName<br>$CustomerID<br>$MyReferralLink<br>");

		exit();
	}

	$InviteKey = $_REQUEST['ref'];
	if(isset($InviteKey)) 
	{
		$CustomerID = invitekey_decode($InviteKey);
		if($CustomerID == 0)
		{
			die("bad invite key $InviteKey");
		}

		// create & execute query
		$tsql   = "SELECT AccountName from LoginID where CustomerID=?";
		$params = array($CustomerID);
		$member = db_exec($conn, $tsql, $params);
		
		echo("$InviteKey<br>$CustomerID : " . $member['AccountName'] . "<br>");

		exit();
	}

	die('need ?id= with AccountName OR ?ref= with invite key code');
?>
