<?php
	require_once('dbinfo.inc.php');
	require_once('class.inputfilter.php');
	
	$CustomerID = ms_escape_string($_POST["s_id"]);
	$SessionKey = ms_escape_string($_POST["s_key"]);

	//Create query
	$query = "EXECUTE ECLIPSE_UPDATELOGINSESSION '$CustomerID', '$SessionKey'";

	$result = mssql_query($query);
	if($result)
	{
		$m  = mssql_fetch_assoc($result);
		$rc = $m['ResultCode'];
		$ip = $m['IP'];
		echo "$rc $ip";
	}
	else
	{
		echo "1 0.0.0.0";
	}

	mssql_close($con);
?>