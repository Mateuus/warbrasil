<?php
	function file_get_contents_curl($url) 
	{
		$ch = curl_init();
	
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //Set curl to return the data instead of printing it to the browser.
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_FAILONERROR, true);
	
		$data = curl_exec($ch);

		if(curl_errno($ch))
		{
			echo "curl_exec failed<br>";
			print_r(curl_getinfo($ch));
			echo "<br><br>";
			echo curl_errno($ch) . '-' . curl_error($ch) . '<br>';
			exit();
		}

		curl_close($ch);
		return $data;
	}
?>