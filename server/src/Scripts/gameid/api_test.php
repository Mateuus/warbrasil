<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	$query  = "EXECUTE WO_GETINVENTORY '1000'";
	$result = wo_mssql_exec($query);
	$member = mssql_fetch_assoc($result);

	//Create query
	echo "Yoyoy2<br>";
	var_dump($member);

	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member = mssql_fetch_assoc($result);
		echo $member['ItemID'] . "<br>";
	}

	mssql_close($con);
?>