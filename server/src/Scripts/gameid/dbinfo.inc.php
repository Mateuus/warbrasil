<?php
$user="game_api_user";
$pass="heU7DS89&kjdhK7";
$database="gameid_v1";
$db_apikey = "ACOR4823G%sjYU*@476xnDvYaK@!56";

$con = mssql_connect("db1.thewarinc.com,11433","$user","$pass");
@mssql_select_db("$database") or die( "Unable to select database");

function ms_escape_string($data) 
{
	if ( !isset($data) or empty($data) )
		return '';
	if ( is_numeric($data) )
		return $data;

	$non_displayables = array(
		'/%0[0-8bcef]/',            // url encoded 00-08, 11, 12, 14, 15
		'/%1[0-9a-f]/',             // url encoded 16-31
		'/[\x00-\x08]/',            // 00-08
		'/\x0b/',                   // 11
		'/\x0c/',                   // 12
		'/[\x0e-\x1f]/'             // 14-31
	);         

	foreach ( $non_displayables as $regex )
		$data = preg_replace( $regex, '', $data );

	$data = str_replace("'", "''", $data );
	return $data;     
}

?>