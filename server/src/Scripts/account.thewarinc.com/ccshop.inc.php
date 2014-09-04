<?php
	$SHOP_URL_VFCODE = "aV4aHvdwb";

function exec_shop_call($post_data)
{
	global $SHOP_URL_VFCODE;

	// add common payment gateway parameters
	$post_data['mode']        = 'Payonly';
	$post_data['storename']   = '1001292401';
	$post_data['suppressTitle'] = 'True';

	// our verification code for callback urls
	$post_data['x_vfcode']    = $SHOP_URL_VFCODE;

	//traverse array and prepare data for posting (key1=value1)
	$post_items = array();
	foreach ( $post_data as $key => $value) {
		$post_items[] = urlencode($key) . '=' . urlencode($value);
	}

	//create the final string to be posted using implode()
	$post_string = implode ('&', $post_items); 

	$PostURL = "https://www.linkpointcentral.com/lpc/servlet/lppay";

	// exec curl
	$ch = curl_init($PostURL);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_HEADER, false);  // DO NOT RETURN HTTP HEADERS
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3");
	curl_setopt($ch, CURLOPT_AUTOREFERER, false);
	curl_setopt($ch, CURLOPT_REFERER, 'https://account.thewarinc.com/gen-x-2948250-UID23920.php');

	$Rec_Data = curl_exec($ch);
	echo "$Rec_Data";
	//exit();

	/*
	//show information regarding the request
	print_r(curl_getinfo($ch));
	echo curl_errno($ch) . '-' . 	curl_error($ch);
	*/

	//curl_close($ch);
}
?>