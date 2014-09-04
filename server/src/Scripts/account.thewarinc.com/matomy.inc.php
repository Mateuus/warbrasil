<?php

function matomy_get_geoIpCode()
{
	global $_SERVER;

	// get country geo-ip code
	require_once('./geoip/ip2location.class.php');

	$ip2loc = new ip2location;
	$ip2loc->open('./geoip/IP-COUNTRY-QFTJCX.BIN');

	$geoRecord = $ip2loc->getAll($_SERVER['REMOTE_ADDR']);
	$geoIpCode = $geoRecord->countryShort;

	return $geoIpCode;
}

function matomy_exec_curl($url, $name, $fp)
{
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_HEADER, false);  // DO NOT RETURN HTTP HEADERS
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

	$httpResponse = curl_exec($ch);

/*
	fwrite($fp, "$name: $url\n");
	if(!$httpResponse) {
		fwrite($fp, "$name: $url *FAILED* " . curl_error($ch) . "\n");
	} else {
		fwrite($fp, "$name: $url ok: $httpResponse\n");
	}
*/

	curl_close($ch);
}

function matomy_do_conversion($conn, $CustomerID, $geoIpCode, $in_saleId, $in_salePrice, $in_orderId)
{
	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_MatomyDoConversion ?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);

	$ResultCode = $member['ResultCode'];
	$ce_pub = $member['ce_pub'];
	$ce_cid = $member['ce_cid'];
	if(!isset($ResultCode)) {
		die('matomy_ResultCode');
	}
	if($ResultCode == 1) {
		// not matomy user
		return;
	}

/*
	$fp = fopen("1/matomy.txt", "a+");
	fwrite($fp, "\n\nmatomy_do_conversion: $CustomerID, $geoIpCode, $in_saleId, $in_salePrice, $in_orderId<br>\n");
	fwrite($fp, "rc: $ResultCode<br>\n");
*/

	$tier      = 0;
	$salePixel = "";
	$saleUrl   = "";

	// detect matomy tier
	if($geoIpCode == 'US' || 
	   $geoIpCode == 'DE' ||
	   $geoIpCode == 'SE' ||
	   $geoIpCode == 'DK' ||
	   $geoIpCode == 'NO') 	
	{
		$tier      = 1;
		$salePixel = "https://network.adsmarket.com/cpx?script=1&optp=1&programid=37761&campaignid=246791&action=sale&currency=USD";
		$saleUrl   = "https://network.adsmarket.com/cevent?type=sale&programid=37761&campaignid=246791&currency=USD";
	}
	else if(
	   $geoIpCode == 'CA' ||
	   $geoIpCode == 'UK' ||
	   $geoIpCode == 'FR' ||
	   $geoIpCode == 'IT') 
	{
		$tier      = 2;
		$salePixel = "https://network.adsmarket.com/cpx?script=1&optp=1&programid=37761&campaignid=246801&action=sale&currency=USD";
		$saleUrl   = "https://network.adsmarket.com/cevent?type=sale&programid=37761&campaignid=246801&currency=USD";
	}
	else
	{
		// not supported matomy country, skip
		return;
	}

	$priceText = sprintf("%.02f", $in_salePrice);

	// exec conversion pixel
	{
		$salePixel .= "&amount=$priceText";
		$salePixel .= "&productid=$in_saleId";
		$salePixel .= "&orderid=$in_orderId";

		matomy_exec_curl($salePixel, "salePixel", $fp);
	}

	// check if we did actual conversion
	if($ResultCode == 0)
	{
		$saleUrl .= "&visitor_cid=$ce_cid";
		$saleUrl .= "&amount=$priceText";
		$saleUrl .= "&productid=$in_saleId";
		$saleUrl .= "&orderid=$in_orderId";
		$saleUrl .= "&advertiser_info=$CustomerID";

		matomy_exec_curl($saleUrl, "saleUrl", $fp);
	}

}
?>