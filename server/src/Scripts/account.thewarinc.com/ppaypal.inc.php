<?php

$environment = 'live';	// or 'sandbox' or 'beta-sandbox' or 'live'

/**
 * Send HTTP POST Request
 *
 * @param	string	The API method name
 * @param	string	The POST Message fields in &name=value pair format
 * @return	array	Parsed HTTP Response body
 */
function PPHttpPost($methodName_, $nvpStr_) {
	global $environment;

	// Set up your API credentials, PayPal end point, and API version.

	if("sandbox" === $environment)
	{
		// SANDBOX
		$API_UserName = urlencode('denis1_1302622068_biz_api1.arktosentertainment.com');
		$API_Password = urlencode('1302622080');
		$API_Signature = urlencode('AlKTBly-iaL11GhDW0iRUApHmjYNAImYLdaLrFXN3UonimZVoscIwX6A');
	} 
	else
	{
  		// LIVE
		$API_UserName = urlencode('billing_api1.thewarinc.com');
		$API_Password = urlencode('2P36RCHDG852SGRN');
		$API_Signature = urlencode('ANJAKZqmXKD0fj-z96X57XuWkhuVAXiBoLnmq3shv.SUl984GpNxxl.4');
	}

	$API_Endpoint = "https://api-3t.paypal.com/nvp";
	if("sandbox" === $environment || "beta-sandbox" === $environment) {
		$API_Endpoint = "https://api-3t.$environment.paypal.com/nvp";
	}
	$version = urlencode('63.0');

	// setting the curl parameters.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $API_Endpoint);
	curl_setopt($ch, CURLOPT_VERBOSE, 1);

	// Set the curl parameters.
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_POST, 1);

	// Set the API operation, version, and API signature in the request.
	$nvpreq = "METHOD=$methodName_&VERSION=$version&PWD=$API_Password&USER=$API_UserName&SIGNATURE=$API_Signature$nvpStr_";

	// Set the request as a POST FIELD for curl.
	curl_setopt($ch, CURLOPT_POSTFIELDS, $nvpreq);

	// Get response from the server.
	$httpResponse = curl_exec($ch);

	if(!$httpResponse) {
		exit('$methodName_ failed: '.curl_error($ch).'('.curl_errno($ch).')');
	}

	// Extract the response details.
	$httpResponseAr = explode("&", $httpResponse);

	$httpParsedResponseAr = array();
	foreach ($httpResponseAr as $i => $value) {
		$tmpAr = explode("=", $value);
		if(sizeof($tmpAr) > 1) {
			$httpParsedResponseAr[$tmpAr[0]] = $tmpAr[1];
		}
	}

	if((0 == sizeof($httpParsedResponseAr)) || !array_key_exists('ACK', $httpParsedResponseAr)) {
		exit("Invalid HTTP Response for POST request($nvpreq) to $API_Endpoint.");
	}

	return $httpParsedResponseAr;
}

function PPAddNVPItem($itemName, $itemPrice, $custom)
{
	$nvpStr  = "";
	$nvpStr .= "&PAYMENTREQUEST_0_CURRENCYCODE="  . "USD";
	$nvpStr .= "&PAYMENTREQUEST_0_AMT="           . urlencode($itemPrice);
	$nvpStr .= "&PAYMENTREQUEST_0_ITEMAMT="       . urlencode($itemPrice);
	$nvpStr .= "&PAYMENTREQUEST_0_NAME="          . urlencode($itemName);
	$nvpStr .= "&PAYMENTREQUEST_0_CUSTOM="        . urlencode($custom);
	$nvpStr .= "&L_PAYMENTREQUEST_0_AMT0="        . urlencode($itemPrice);
	$nvpStr .= "&L_PAYMENTREQUEST_0_NAME0="       . urlencode($itemName);

	return $nvpStr;
}

?>