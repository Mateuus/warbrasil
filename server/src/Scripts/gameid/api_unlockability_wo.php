<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();
	$AbilityID  = get_param('AbilityID');

	$query  = "EXECUTE WO_UNLOCKABILITY '$LastIP', '$CustomerID', '$AbilityID'";
	$result = wo_mssql_exec($query);

	// output resulted slots and remaining game points
	$member = mssql_fetch_assoc($result);

	wo_echo_result('0');
	$gp = $member['GamePoints'];
	echo "$gp";
	
	mssql_close($con);
?>
