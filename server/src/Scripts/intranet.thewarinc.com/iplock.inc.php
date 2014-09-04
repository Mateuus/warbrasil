<?php
	$Last_IP = $_SERVER['REMOTE_ADDR']; 
	if($Last_IP != '173.196.5.194' && 
	   $Last_IP != '74.208.44.54')
	{
		die("fraud $Last_IP");
	}
?>
