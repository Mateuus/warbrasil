<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$CustomerID = wo_get_CustomerID();
	$query  = "EXECUTE WO_GETINVENTORY '$CustomerID'";
	$result = wo_mssql_exec($query);

	header("Content-type: text/xml"); 
	$xml = "<?xml version=\"1.0\"?>\n"; 
	$xml .= "<inventory>\n";

	for($x = 0; $x < mssql_num_rows($result); $x++)
	{ 
		$member = mssql_fetch_assoc($result);
		if($member == false)
			break;

    		$xml .= "<item \n";
		$xml .= xml_attr("ItemID", $member['ItemID']);
		$xml .= xml_attr("MinLeft", $member['MinutesLeft']);
		$xml .= "/>\n";
	}               

	$xml .= "</inventory>"; 
	echo $xml;
	
	mssql_close($con);

?>
