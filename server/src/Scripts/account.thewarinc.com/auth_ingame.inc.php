<?php

function ingame_autologin()
{
	require_once('dbinfo.inc.php');

	$l1 = $_REQUEST['WoLogin'];
	if(!isset($l1))
		return;

	// decode base64 XOR'ed string
	$l2 = base64_decode($l1);
	if($l2 === FALSE) {
		return;
	}
	$l3 = "";
	for($i=0; $i<strlen($l2); $i++)
		$l3 .= chr(ord($l2[$i]) ^ 0x64);

	// get customerid/sessionid
	$l4 = explode(":", $l3);
	$CustomerID   = $l4[0];
	$SessionID    = $l4[1];
	//echo "cust: $CustomerID<br>";
	//echo "sess: $SessionID<br>";

	if(!isset($CustomerID) || !isset($SessionID))
		return;

	$Last_IP      = $_SERVER['REMOTE_ADDR']; 

	// create & execute query
	$tsql   = "EXEC WO_UPDATELOGINSESSION ?, ?, ?";
	$params = array($Last_IP, $CustomerID, $SessionID);
	$member = db_exec($conn, $tsql, $params);
	if($member["ResultCode"] != 0)
	{
		// login failed
		return;
	}	

	// create & execute query
	$tsql   = "SELECT AccountName, g1.GamersfirstID";
        $tsql  .= " FROM LoginID l";
	$tsql  .= " LEFT JOIN GamersfirstUserIDMap g1 on g1.CustomerID=l.CustomerID";
	$tsql  .= " WHERE l.CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);

	// login Ok, set session and continue
	$_SESSION['CustomerID']  = $CustomerID;
	$_SESSION['AccountName'] = $member["AccountName"];

	$GamersfirstID = $member['GamersfirstID'];
	if(isset($GamersfirstID) && $GamersfirstID > 0)
		$_SESSION['GamersfirstID'] = $GamersfirstID;

	return;
}
?>