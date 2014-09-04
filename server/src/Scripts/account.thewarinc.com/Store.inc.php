<?php

//
// define all items in the shop
//
$shop_prices = array(
	// code			CCPrice	PPprice	SMSrow	G1CRow	Desc
	"TESTTEST"	=> array(0.20,	0.10,	0,	7,	"Test Item Used For Store Check"),

	"GP1500"	=> array(0,	0,	1,	0,	"1,500 Gold Credits"),
	"GP2500"	=> array(0,	0,	2,	0,	"2,500 Gold Credits"),
	"GP4000"	=> array(0,	0,	3,	0,	"4,000 Gold Credits"),
	"GP5000"	=> array(0,	0,	4,	0,	"5,000 Gold Credits"),
	"GP10K"		=> array(0,	0,	5,	0,	"10,000 Gold Credits"),

	"GPX4"		=> array(4.99,	5.49,	-1,	0,	"3,680 Gold Credits"),
	"GPX10"		=> array(9.99,	10.99,	-1,	0,	"7,370 Gold Credits"),
	"GPX20"		=> array(19.99,	20.99,	-1,	0,	"18,220 Gold Credits"),
	"GPX25"		=> array(23.99,	24.99,	-1,	0,	"21,880 Gold Credits"),
	"GPX50"		=> array(42.99,	43.99,	-1,	0,	"44,080 Gold Credits"),

	//NOTE: special G1C Items - last row is GC amount, not $
	"G1C_GPX4"	=> array(0,	0,	-1,	4000,	"4,000 Gold Credits"),
	"G1C_GPX10"	=> array(0,	0,	-1,	10000,	"10,000 Gold Credits"),
	"G1C_GPX20"	=> array(0,	0,	-1,	20000,	"20,000 Gold Credits"),
	"G1C_GPX30"	=> array(0,	0,	-1,	30000,	"30,000 Gold Credits"),
	"G1C_GPX50"	=> array(0,	0,	-1,	50000,	"50,000 Gold Credits"),
	"G1C_GPX99"	=> array(0,	0,	-1,	990000,	"50,000 Gold Credits"),
	//G1C ITEMS END

	"PACK_RETAIL1"	=> array(0,	0,	-1,	0,	"HARDBOILED pack"),
	"PACK_RETAIL2"	=> array(0,	0,	-1,	0,	"SNAKEEATER pack"),
	"PACK_RETAIL3"	=> array(0,	0,	-1,	0,	"WARLORD pack"),

	//"PACK_COLLECTOR_EDITION"	=> 
	//		   array(34.99,	34.99,	-1,	0,	"Digital Collectors Edition"),

	// add new items above
	"-end-"		=> array(0,	0,	-1,	0,	"-------")
	);

function store_GetItemPriceDescByCode($x_id, $PayCode)
{
	global $shop_prices;

	$data = $shop_prices[$x_id];
	if(! $data)
		die("Unknown item code $x_id");

	$price = $data[$PayCode];
	if($price <= 0 && $x_id != "TESTTEST")
		die("price is not set for $x_id with PayCode:$PayCode");

	return array($price, $data[4]);
}

function store_GetItemDesc($x_id)
{
	global $shop_prices;

	$data = $shop_prices[$x_id];
	if(! $data)
		return $x_id;
	return $data[4];
}

function send_payment_email($email, $oid, $dt, $paym, $billinfo, $item, $price, $show_success_msg)
{
	require_once('PHPMailer_v5.1/class.phpmailer.php');

	$body = file_get_contents("EMails\email_receipt.html");
	$body = ereg_replace("-OID-", $oid, $body);
	$body = ereg_replace("-DT-", $dt, $body);
	$body = ereg_replace("-PAYM-", $paym, $body);
	$body = ereg_replace("-BILLINFO-", $billinfo, $body);
	$body = ereg_replace("-ITEM-", $item, $body);

	// see if $price have "CURRENCY PRICE" format
	if(is_string($price) && strstr($price, " "))
	{
		$temp_arr = explode(" ", $price);
		// replace USD with correct currency
		$body = ereg_replace("USD", $temp_arr[0], $body);
		$body = ereg_replace("-PRICE-", $temp_arr[1], $body);
	}
	else
	{
		$body = ereg_replace("-PRICE-", "$price", $body);
	}

	$mail = new PHPMailer(true); // the true param means it will throw exceptions on errors, which we need to catch

	try {
		$mail->IsSMTP(); // telling the class to use SMTP
		$mail->SMTPDebug  = 1;
		$mail->SMTPAuth   = true;
		$mail->Host       = "smtp.1and1.com";
		$mail->Username   = "support@thewarinc.com";
		$mail->Password   = "Wsxmko!10";

		$mail->SetFrom('support@thewarinc.com', 'Arktos Entertainment Group');
		$mail->Subject    = "Purchase receipt";
		$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!";
		$mail->MsgHTML($body);
		$mail->AddAddress($email, $email);

		$mail->Send();

		if($show_success_msg)
		{
			echo "<br>You receipt was sent to $email<br>";
		}

	} 
	catch (phpmailerException $e) 
	{
		if($show_success_msg)
		{
			echo "<strong>There was error sending mail to $email</strong>";
			echo $e->errorMessage();
		}
	}
	catch (Exception $e)
	{
		if($show_success_msg)
		{
			echo "<strong>There was error sending mail to $email</strong>";
			echo $e->getMessage();
		}
	}
}


?>