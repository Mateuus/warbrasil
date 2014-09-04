<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();

	$query  = "EXECUTE WO_UNLOCKSLOT '$LastIP', '$CustomerID'";
	$result = wo_mssql_exec($query);

	// output resulted slots and remaining game points
	$member = mssql_fetch_assoc($result);

	wo_echo_result('0');
	$ns = $member['NumSlots'];
	$gp = $member['GamePoints'];
	echo "$ns $gp";
	
	mssql_close($con);
?>
