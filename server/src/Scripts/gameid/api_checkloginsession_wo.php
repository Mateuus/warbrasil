<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	$CustomerID = wo_get_CustomerID();
	$SessionKey = ms_escape_string($_POST["s_key"]);
	$LastIP     = $_SERVER['REMOTE_ADDR'];

	// create query
	$query = "EXECUTE WO_UPDATELOGINSESSION '$LastIP', '$CustomerID', '$SessionKey'";
	$result = wo_mssql_exec($query);

	// we're ok
	wo_echo_result('0');

	mssql_close($con);
?>