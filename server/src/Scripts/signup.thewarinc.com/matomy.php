<?php
	session_start();
	$_SESSION['matomy_ce_cid'] = $_REQUEST['ce_cid'];
	$_SESSION['matomy_ce_pub'] = $_REQUEST['ce_pub'];
	
	header("Location: index.php");
?>