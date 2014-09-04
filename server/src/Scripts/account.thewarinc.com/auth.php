<?php
	//check to make sure user is logged in	
	if(!isset($_SESSION['CustomerID']) || (trim($_SESSION['CustomerID'])=='')) {
		$CurrentURL = $_SERVER["PHP_SELF"];
		header("location: /access-denied.php?p=$CurrentURL");
		exit();
	}
?>