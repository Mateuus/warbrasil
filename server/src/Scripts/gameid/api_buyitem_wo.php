<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();
	$ItemID     = get_param('ItemID');
	$BuyDays    = get_param('BuyDays');

	$query  = "EXECUTE WO_BUYITEM '$LastIP', '$CustomerID', '$ItemID', '$BuyDays'";
	$result = wo_mssql_exec($query);

	// we got here, so item was buyed successfully
	wo_echo_result('0');
	
	mssql_close($con);

?>