<?php
	function db_connect()
	{
		$db_user   = "game_api_user";
		$db_pass   = "b2agrickw";
		$db_dbname = "gameid_v1";
		$db_apikey = "ACOR4823G%sjYU*@476xnDvYaK@!56";
		
		$db_serverName     = "db1.thewarinc.com,11433";
		$db_connectionInfo = array(
			"UID" => $db_user,
			"PWD" => $db_pass,
			"Database" => $db_dbname
			//"ReturnDatesAsStrings" => true
			);
		$conn = sqlsrv_connect($db_serverName, $db_connectionInfo);

		if(! $conn)
		{
			//echo "Connection could not be established.\n";
			//die( print_r( sqlsrv_errors(), true));

			header("location: /error-db-down.php");
			exit();
		}

		return $conn;
	}
	
	function db_exec($conn, $tsql, $params)
	{
		$stmt  = sqlsrv_query($conn, $tsql, $params);
		if(! $stmt)
		{
			echo "exec failed.\n";
			die( print_r( sqlsrv_errors(), true));
			//@header("location: login-failed.php");
		}

		$member = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
		return $member;
	}

	$conn = db_connect();
?>
