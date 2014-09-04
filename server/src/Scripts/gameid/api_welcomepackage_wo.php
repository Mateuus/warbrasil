<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();
	$x_package  = get_param('package');
	$x_ability  = get_param('ability');
	$x_skill    = get_param('skill');

	$query  = "EXECUTE WO_WELCOMEPACKAGE '$LastIP', '$CustomerID'";
	$query .= ", '$x_package', '$x_skill', '$x_ability'";
	$result = wo_mssql_exec($query);

	// we got here, so package was applied successfully
	wo_echo_result('0');
	
	mssql_close($con);
?>
