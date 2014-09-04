<?php
	//Start session	
	session_start();

	require_once('dbinfo.inc.php');
	
	require_once('class.inputfilter.php');
	
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

	$LastIP = $_SERVER['REMOTE_ADDR'];
	$username = ms_escape_string($username);
	$password = ms_escape_string($password);

	//Create query
	$query="EXECUTE ECLIPSE_LOGIN_2 '$username', '$password', '$LastIP'";

	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result)
	{
		$member=mssql_fetch_assoc($result);

		$id    = $member['CustomerID'];
		$gp    = $member['GamePoints'];
		$status= $member['AccountStatus'];
		$key   = $member['SessionKey'];
		echo "$id $gp $status $key";
	}
	else
	{
		echo "0 0 0 NOKEY";
	}

	mssql_close($con);
?>