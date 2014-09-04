<?php

function wo_out_shop_item($member)
{
	$p1 = $member['Price1'];
	$p2 = $member['Price7'];
	$p3 = $member['Price30'];
	$p4 = $member['PriceP'];

	if($p1 == 0 && $p2 == 0 && $p3 == 0 && $p4 == 0)
		return "";

	$xml = "<item "; 
	$xml .= 'ItemID="'    . $member['ItemID']   . '" ';
	$xml .= 'Category="'  . $member['Category'] . '" ';
	if($p1 > 0)
		$xml .= 'Price1="'    . $p1 . '" ';
	if($p2 > 0)
		$xml .= 'Price7="'    . $p2 . '" ';
	if($p3 > 0)
		$xml .= 'Price30="'   . $p3 . '" ';
	if($p4 > 0)
		$xml .= 'PriceP="'    . $p4 . '" ';
	$xml .= "/>\n"; 

	return $xml;
}


	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$query  = "EXECUTE WO_GETALLITEMSPRICE";
	$result = wo_mssql_exec($query);

	header("Content-type: text/xml"); 
	$xml = "<?xml version=\"1.0\"?>\n"; 
	$xml .= "<itemmall>\n"; 

	// gears
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$xml .= wo_out_shop_item($member);
	}               


	// weapons
	mssql_next_result($result);
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$xml .= wo_out_shop_item($member);
	}               

	// generic
	mssql_next_result($result);
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$xml .= wo_out_shop_item($member);
	}               

	$xml .= "</itemmall>"; 

	echo $xml; 

	mssql_close($con);
?>