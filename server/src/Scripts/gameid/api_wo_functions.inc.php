<?php

// some useful functions


function get_param($id)
{
	if($_POST[$id] == NULL)
	{
		wo_echo_result('5');
		echo "missing parameter";
		exit();
	}

	$param = ms_escape_string($_POST[$id]);
	return $param;
}

function wo_get_CustomerID()
{
	return get_param("s_id");
}

// output api result prefix and status code
function wo_echo_result($rc)
{
	echo "WO_$rc";
}

function wo_mssql_exec($query)
{
	$result = mssql_query($query);
	if($result == false)
	{
		wo_echo_result('5');
		echo "SQL query failed";
		exit();
	}

	if(is_bool($result))
	{
		wo_echo_result('5');
		echo "ResultCode not returned";
		exit();
	}

	$member=mssql_fetch_assoc($result);
	$rc = $member['ResultCode'];
	if(is_null($rc))
	{
		wo_echo_result('5');
		echo "ResultCode not set";
		exit();
	}

	if($rc != 0)
	{
		wo_echo_result($rc);
		echo "query logic failed";
		exit();
	}

	// move to next select, where data should be
	mssql_next_result($result);

	return $result;
}

function wo_check_session()
{
	$CustomerID = wo_get_CustomerID();
	$SessionKey = ms_escape_string($_POST["s_key"]);
	$LastIP     = $_SERVER['REMOTE_ADDR'];

	// special GUID for server calls
	if($SessionKey == '{9CCA70CD-62C3-4341-A559-2EFD285B0FC0}')
	{
		return true;
	}

	// create query
	$query = "EXECUTE WO_UPDATELOGINSESSION '$LastIP', '$CustomerID', '$SessionKey'";
	$result = wo_mssql_exec($query);

	return true;
}

function xml_attr($name, $var)
{
	$xml = $name . '="' . htmlentities($var) . '" ' . "\n";
	return $xml;
}

?>
