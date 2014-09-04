<?php
	session_start();
	require_once('auth.php');

	function db_update($conn, $postvar, $db_field)
	{
		$CustomerID = $_SESSION['CustomerID'];

		if(!isset($_POST[$postvar]))
			return;

		// create & execute query
		$tsql   = "UPDATE AccountInfo SET $db_field=? WHERE CustomerID=?";
		$params = array($_POST[$postvar], $CustomerID);
		$member = db_exec($conn, $tsql, $params);
	}

	function db_update2($conn, $postvar, $db_field)
	{
		$CustomerID = $_SESSION['CustomerID'];

		if(!isset($_POST[$postvar]))
			return;

		// create & execute query
		$tsql   = "UPDATE LoginID SET $db_field=? WHERE CustomerID=?";
		$params = array($_POST[$postvar], $CustomerID);
		$member = db_exec($conn, $tsql, $params);
	}
	
	require_once('dbinfo.inc.php');

	db_update($conn, 'firstname', 'firstname');
	db_update($conn, 'lastname',  'lastname');
        db_update($conn, 'email',     'email');
	db_update($conn, 'sex',       'sex');
	db_update($conn, 'street',    'street');
	db_update($conn, 'city',      'city');
	db_update($conn, 'zip',       'postalcode');
	db_update($conn, 'state',     'state');
	db_update($conn, 'country',   'Country');
	db_update($conn, 'phone',     'phone');

	// newletter OptOut1 - reverse var. unchecked box is not set
	if(isset($_POST['news']) && $_POST['news'] == "1")
		$_POST['news'] = "0";
	else
		$_POST['news'] = "1";
	db_update($conn, 'news',      'OptOut1');

	//db_update2($conn, 'gamertag',     'gamertag');

	if(isset($_POST['dob_year']))
	{
		$CustomerID = $_SESSION['CustomerID'];
		$dob_year  = $_POST['dob_year'];
		$dob_month = $_POST['dob_month'];
		$dob_day   = $_POST['dob_day'];

		$date   = "$dob_year-$dob_month-$dob_day";

		$tsql   = "UPDATE AccountInfo SET dob=? WHERE CustomerID=?";
		$params = array($date, $CustomerID);
		$member = db_exec($conn, $tsql, $params);
	}
	
	header("location: profile.php");
?>
