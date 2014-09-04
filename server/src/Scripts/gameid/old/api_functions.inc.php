<?php

function check_if_login_session_valid()
{
	$CustomerID = ms_escape_string($_POST["s_id"]);
	$SessionKey = ms_escape_string($_POST["s_key"]);

	// special GUID for server calls
	if($SessionKey == '{9CCA70CD-62C3-4341-A559-2EFD285B0FC0}')
	{
		return true;
	}

	//Create query
	$query = "EXECUTE ECLIPSE_UPDATELOGINSESSION '$CustomerID', '$SessionKey'";

	$result = mssql_query($query);
	if($result)
	{
		$m  = mssql_fetch_assoc($result);
		$rc = $m['ResultCode'];
		$ip = $m['IP'];
		if($rc == 0)
		{
			return true;
		}

		echo "BAD_LOGIN_SESSION $rc $ip";
		return false;
	}
	else
	{
		echo "BAD_LOGIN_SESSION no_row";
	}
}

function get_customer_id()
{
	$CustomerID = ms_escape_string($_POST["s_id"]);
	return $CustomerID;
}

function get_param($id)
{
	$param = ms_escape_string($_POST[$id]);
	return $param;
}

?>
