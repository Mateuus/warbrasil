<?php
	require_once('dbinfo.inc.php');
	require_once('class.inputfilter.php');
	require_once('api_wo_functions.inc.php');
	
	$_POST["username"] = stripslashes($_POST["username"]);
	// tags array
	$tags = explode(',', $_POST["tags"]);
	for ($i = 0; $i < count($tags); $i++) $tags[$i] = trim($tags[$i]);
	// attr array
	$attr = explode(',', $_POST["attr"]);
	for ($i = 0; $i < count($attr); $i++) $attr[$i] = trim($attr[$i]);
	// select fields
	$tag_method = $_POST["tagmethod"];
	$attr_method = $_POST["attrmethod"];
	if ($_POST["xssauto"] == 'n') $xss_auto = 0;
	else $xss_auto = 1;
	// more info on parameters in documentation.
	$myFilter = new InputFilter($tags, $attr, $tag_method, $attr_method, $xss_auto);
	// process input
	$username = $myFilter->process($_POST["username"]);
	
	$_POST["password"] = stripslashes($_POST["password"]);
	// tags array
	$tags = explode(',', $_POST["tags"]);
	for ($i = 0; $i < count($tags); $i++) $tags[$i] = trim($tags[$i]);
	// attr array
	$attr = explode(',', $_POST["attr"]);
	for ($i = 0; $i < count($attr); $i++) $attr[$i] = trim($attr[$i]);
	// select fields
	$tag_method = $_POST["tagmethod"];
	$attr_method = $_POST["attrmethod"];
	if ($_POST["xssauto"] == 'n') $xss_auto = 0;
	else $xss_auto = 1;
	// more info on parameters in documentation.
	$myFilter = new InputFilter($tags, $attr, $tag_method, $attr_method, $xss_auto);
	// process input
	$password = $myFilter->process($_POST["password"]);

	$LastIP   = $_SERVER['REMOTE_ADDR'];
	$username = ms_escape_string($username);
	$password = ms_escape_string($password);

	// create and execute query
	$query  = "EXECUTE WO_LOGIN '$LastIP', '$username', '$password'";
	$result = wo_mssql_exec($query);
	$member = mssql_fetch_assoc($result);

	$id     = $member['CustomerID'];
	$gp     = $member['GamePoints'];
	$status = $member['AccountStatus'];
	$key    = $member['SessionKey'];

	wo_echo_result('0');
	echo "$id $gp $status $key";

	mssql_close($con);
?>