<?php
	if($_SERVER['SERVER_PORT']==443)
	{
		$url = "http://" . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];
		header("Location: $url");
	}
?>
