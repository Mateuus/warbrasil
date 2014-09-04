<?php

require_once('./geoip/ip2location.class.php');

$ip = new ip2location;
$ip->open('./geoip/IP-COUNTRY-QFTJCX.BIN');

$record = $ip->getAll($_SERVER['REMOTE_ADDR']);
$code   = $record->countryShort;

$redir = false;
if($code == "RU") $redir = true; //RUSSIA
if($code == "UA") $redir = true; //UKRAINE    
if($code == "BY") $redir = true; //BELARUS
if($code == "KZ") $redir = true; //KAZAKHSTAN

if($_SERVER['REMOTE_ADDR'] == "80.240.210.87") $redir = false;

if($redir)
{
	header("Location: http://www.warinc.ru");
	exit();
}

//echo '<b>Country Short:</b> ' . $record->countryShort . '<br>';
?>