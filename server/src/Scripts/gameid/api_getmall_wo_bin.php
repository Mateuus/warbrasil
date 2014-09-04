<?php

function wo_out_shop_item($member)
{
	$p1 = $member['Price1'];
	$p2 = $member['Price7'];
	$p3 = $member['Price30'];
	$p4 = $member['PriceP'];

	if($p1 == 0 && $p2 == 0 && $p3 == 0 && $p4 == 0)
		return "";

	$priceBits = 0;
	if($p1 > 0) $priceBits = $priceBits | 1;
	if($p2 > 0) $priceBits = $priceBits | 2;
	if($p3 > 0) $priceBits = $priceBits | 4;
	if($p4 > 0) $priceBits = $priceBits | 8;

	$out  = "";
	$out .= pack("L", $member['ItemID']);
	$out .= pack("C", $priceBits);
	$out .= pack("C", $member['Category']);
	if($p1 > 0) $out .= pack("S", $p1);
	if($p2 > 0) $out .= pack("S", $p2);
	if($p3 > 0) $out .= pack("S", $p3);
	if($p4 > 0) $out .= pack("S", $p4);

	return $out;
}


	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$query  = "EXECUTE WO_GETALLITEMSPRICE";
	$result = wo_mssql_exec($query);

	header("Content-type: application/octet-stream");
	$out = "SHO1";

	// gears
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$out .= wo_out_shop_item($member);
	}               


	// weapons
	mssql_next_result($result);
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$out .= wo_out_shop_item($member);
	}               

	// generic
	mssql_next_result($result);
	for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
	{ 
		$member=mssql_fetch_assoc($result);
		$out .= wo_out_shop_item($member);
	}               

	$out .= "SHO1";

	wo_echo_result('0');
	echo $out;

	mssql_close($con);
?>
