<?php
function cc_is_country_allowed()
{
	if($_SERVER['REMOTE_ADDR'] == "80.240.210.87") 
		return true;

	//return false; - global enable/disable

	require_once('./geoip/ip2location.class.php');

	$ip = new ip2location;
	$ip->open('./geoip/IP-COUNTRY-QFTJCX.BIN');

	$record = $ip->getAll($_SERVER['REMOTE_ADDR']);
	$code   = $record->countryShort;
	
	//if($_SERVER['REMOTE_ADDR'] == "108.60.55.50")
	//	return false;

	if($code == "US") return true; // UNITED STATES
	if($code == "UK") return true; // UNITED KINGDOM
	if($code == "FR") return true; // FRANCE
	if($code == "AU") return true; // AUSTRALIA
	if($code == "CA") return true; // CANADA
	if($code == "DK") return true; // DENMARK
	if($code == "DE") return true; // GERMANY
	if($code == "NO") return true; // NORWAY
	if($code == "SE") return true; // SWEDEN
	if($code == "FI") return true; // FINLAND
	if($code == "IT") return true; // ITALY
	if($code == "JP") return true; // JAPAN
	if($code == "NZ") return true; // NEW ZEALAND
	if($code == "NL") return true; // NETHERLANDS
	if($code == "IL") return true; // ISRAEL
	if($code == "BE") return true; // BELGIUM
	if($code == "ES") return true; // SPAIN
	if($code == "AT") return true; // AUSTRIA
	if($code == "CH") return true; // SWITZERLAND
	if($code == "IE") return true; // IRELAND
	
	// all others is denied
	return false;
}
?>