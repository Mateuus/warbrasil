<?php
	if($_SERVER['SERVER_PORT']!=443)
	{
		$url = "https://" . $_SERVER['SERVER_NAME'] . ":443" . $_SERVER['REQUEST_URI'];
		header("Location: $url");
	}
?>
