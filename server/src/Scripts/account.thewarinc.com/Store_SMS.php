<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 
	
	require_once('store.inc.php');

	$CustomerID = $_SESSION['CustomerID'];
	
	// execute geo-ip boku lookup call
	$Last_IP = $_SERVER['REMOTE_ADDR']; 
	$xml  = exec_boku_call("lookup", "&ip-address=$Last_IP");
	$GeoCountry = $xml["lookupResult"]["geo-country-code"];
	
	
	$_SESSION['lastpage'] = "store_sms.php";
?>
<?php
	function show_item_row($itemid)
{
	global $CustomerID;
	global $GeoCountry;

	// get item price and desc
	list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($itemid, 2);

	// get item price from boku
	$url  = "&row-ref=$x_price";
	$url .= "&country=$GeoCountry";
	$xml  = exec_boku_call("service-prices", $url);

	$attr     = $xml["service"]["key-value"]["pricing"]["@attributes"];
	if(!isset($attr["amount"]))
	{
		echo "<p class=\"name\">$Item_Desc is not available in your country ($GeoCountry)</p>";
		echo "<br>";
		return;
	}

	$price    = $attr["amount"] / 100.0;
	$currency = $attr["currency"];
	$cdp      = $attr["currency-decimal-places"];

	// format with correct decimal places
	$fmt      = "%.$cdp" . "f";
	$price2   = sprintf($fmt, $price);

	echo "<a target=\"_blank\" href=\"smsstartpay.php?ItemID=$itemid\">";
	echo "Click To buy $Item_Desc for $$price2 $currency";
	echo "</a>";
	echo "<br>";
}

function exec_boku_call($func, $data)
{
	$url  = "https://api2.boku.com/billing/request?action=$func";
	$url .= "&merchant-id=arktosgroup";
	$url .= "&password=f1gz45hd5";
	$url .= "&service-id=6dfb7ffc7a8c4f6724a3777d";
	$url .= $data;

	// setting the curl parameters.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_VERBOSE, 1);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_POST, 0);

	// Get response from the server.
	$resp = curl_exec($ch);
	if(!$resp) {
		exit('SMS prepare failed: '.curl_error($ch).'('.curl_errno($ch).')');
	}

	// parse returned XML
	$xml_obj = simplexml_load_string($resp);
	$xml     = object2array($xml_obj);

	return $xml;
}

function object2array($object) 
{ 
	return @json_decode(@json_encode($object),1); 
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Store</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->
<script type="text/javascript" src="js/analytics.js"></script>
</head>
<body>
<div class="main_bg1">
	<div class="main_bg">&nbsp;</div>
</div>
<div class="root">							
<!-- BEGIN BODY -->


	
<!-- BEGIN HEADER -->

	<div id="header">
		<div class="header">
			<a href="index.php"   class="logo"></a>
			<div class="block_id" align="right">
				<a href="profile.php"   class="name"><?php echo $_SESSION['AccountName']; ?></a>
				<a href="logout-exec.php"   class="logout"></a>
			</div>
			<div class="cL"></div>
			<div class="line_header"></div>
			<ul class="navigation">
				<li class="menu_1"><a href="home.php"></a></li>
				<li class="menu_2"><a href="profile.php"></a></li>
				<li class="menu_3"><a href="invitefriends.php"></a></li>
				<li class="menu_4"><a href="key.php"></a></li>
				<li class="menu_5 active_5"><a href="store.php"></a></li>
				<li class="menu_6"><a href="earn.php"></a></li>
				<li class="menu_7"><a href="history.php"></a></li>
			</ul>
			<div class="cL"></div>
		</div>
	</div>
	
<!-- HEADER EOF   -->	

<!-- BEGIN CONTENT -->

	<div id="content">		
		<div class="shadow7_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
				
				<div class="block_text">
					<?php
							//show_item_row("TESTTEST");

							show_item_row("GP1500");
							show_item_row("GP2500");
							show_item_row("GP4000");
							show_item_row("GP5000");
							show_item_row("GP10K");

						?>

						
						<p class="inf">If you do not see your country or operator in list of SMS payment enabled countries,<br/>please visit <a href="http://www.zoomerang.com/Survey/WEB22CCFWXGWKA/" target="_blank" >Mobile payment service request page</a> to let us know what country you live in, so we can promptly enable SMS service for your country. </p>					
					
					
				</div>
				
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_5"></div></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
