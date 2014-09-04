<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	//wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();
	$SlotID     = get_param('SlotID');
	$i1         = get_param('i1');
	$i2         = get_param('i2');
	$i3         = get_param('i3');
	$i4         = get_param('i4');
	$i5         = get_param('i5');
	$i6         = get_param('i6');
	$i7         = get_param('i7');
	$i8         = get_param('i8');
	$i9         = get_param('i9');
	$i10        = get_param('i10');
	$i11        = get_param('i11');
	$i12        = get_param('i12');
	$i13        = get_param('i13');

	$query  = "EXECUTE WO_UPDATELOADOUT '$LastIP', '$CustomerID', '$SlotID'";
	$query .= ", '$i1', '$i2', '$i3', '$i4', '$i5', '$i6', '$i7'";
	$query .= ", '$i8', '$i9', '$i10', '$i11', '$i12', '$i13'";
	$result = wo_mssql_exec($query);

	// output correct loadout string
	$member = mssql_fetch_assoc($result);

	wo_echo_result('0');
	$ls = $member['Loadout'];
	echo "$ls";
	
	mssql_close($con);
?>
