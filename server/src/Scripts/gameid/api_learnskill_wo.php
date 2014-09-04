<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();
	$SlotID     = get_param('SkillID');

	$query  = "EXECUTE WO_LEARNSKILL '$LastIP', '$CustomerID', '$SkillID'";
	$result = wo_mssql_exec($query);

	// output resulted slots and remaining game points
	$member = mssql_fetch_assoc($result);

	wo_echo_result('0');
	$sl = $member['SkillLevel'];
	$sp = $member['SkillPoints'];
	echo "$sl $sp";
	
	mssql_close($con);
?>
