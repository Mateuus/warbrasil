<?php

// agreed conversion rate between GC<->G1C
function g1c_GCtoG1C($x_price)  { return (int)($x_price / 7.0); }

// warning: do not modify coeffs here - they used only to store amount in our DB.
// and to convert back/forth for history
function g1c_USDtoG1C($x_price) { return (float)($x_price * 80.0); }
function g1c_G1CtoUSD($x_price) { return (float)($x_price / 80.0); }

function g1c_curl($req, $arr, $use_post, $show_debug)
{
	$SECRET_KEY = "05<R:69o85LRK;y:(sPDY0\"N2.50(1";

	$arr["MerchantKey"] = "1c091916-3c0f-45f0-a5c0-993900caeb90";

	$md5str = "";
	$post   = "";
	foreach($arr as $key => $value)
	{
		if($key[0] == '#') // skipping md5 hash
		{
			$key = ltrim($key, "#");
		}
		else
		{
			$md5str .= $value . "|";
		}

		if($post != "") $post .= "&";
		$post   .= $key . "=" . $value;
	}
	$md5str .= $SECRET_KEY;
	$post   .= "&Hash=" . md5($md5str);

	//$url  = "http://services-devx.connect.gamersfirst.com:8000/GamersFirstConnect/REST/V1.2/";
	$url  = "https://services.connect.gamersfirst.com/GamersFirstConnect/REST/V1.2/";
	$url .= $req;
	if(!$use_post)
		$url .= "?" . $post;

	$ch = curl_init($url);
	if($use_post)
	{
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post);

		if($show_debug)
		{
			echo("POST: @$post@ <br><br>\n\n");
		}
	}
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_HEADER, false);  // DO NOT RETURN HTTP HEADERS
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  // RETURN THE CONTENTS OF THE CALL
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_AUTOREFERER, false);
	$ans  = curl_exec($ch);

	$json = json_decode($ans);

	if($show_debug)
	{
		echo("hash_value: @$md5str@ <br><br>\n\n");
		echo("REQ:  @$url@ <br><br>\n\n");
		echo("ANS:  $ans <br><br>\n\n");
		var_dump($json);
	}

	return $json;
}

function g1c_GetBalance()
{
	$GamersfirstId = $_SESSION['GamersfirstID'];
	if(!isset($GamersfirstId))
		die('!GamersfirstId');

	$arr["accountId"] = $GamersfirstId;
	$ans = g1c_curl("Payments/GetBalance.json", $arr, false, false);

	$rc = $ans->Result;
	if($rc == "1")
	{
		die("Gamersfirst account is not found");
	}
	if($rc == "2")
	{
		die("Your Gamersfirst account is restricted from participation in payments");
	}
	if($rc != "0")
	{
		die("Unknown result code $rc getting Gamersfirst G1C balance. Please try again later");
	}

	return (float)$ans->Balance;
}

function g1c_BuyItem($itemId, $g1cost, $transactionId)
{
	$GamersfirstId = $_SESSION['GamersfirstID'];
	if(!isset($GamersfirstId))
		die('!GamersfirstId');

	$arr["accountId"]        = $GamersfirstId;
	$arr["transactionId"]    = urlencode(strtolower($transactionId));
	$arr["cost"]             = $g1cost;
	$arr["#gameUsername"]    = urlencode($_SESSION["AccountName"]);
	$arr["#itemId"]          = $itemId;
	$arr["#description"]     = $itemId;
	$arr["#clientIpAddress"] = $_SERVER['REMOTE_ADDR'];
	$ans  = g1c_curl("Payments/RequestTransaction.json", $arr, true, false);

	$rc = $ans->Result;
	if($rc == "1")
	{
		die("Gamersfirst account is not found");
	}
	if($rc == "2")
	{
		die("Your Gamersfirst account is restricted from participation in payments");
	}
	if($rc == "7")
	{
		die("The account has insufficient GamersFirst credits for this purchase");
	}
	if($rc != "0")
	{
		die("Unknown result code $rc making purchase. Please try again later");
	}

	return true;
}

function g1c_TokenStoreValue($token, $name, $value)
{
	$arr["token"] = $token;
	$arr["name"]  = $name;
	$arr["value"] = $value;
	$ans  = g1c_curl("Tokens/StoreValue.json", $arr, true, false);
}

function g1c_GenerateToken($passUrl)
{
	$GamersfirstId = $_SESSION['GamersfirstID'];
	if(!isset($GamersfirstId))
		die('!GamersfirstId');

	$arr["accountId"]        = $GamersfirstId;
	$arr["gameId"]           = "24";
	$ans  = g1c_curl("Tokens/Generate.json", $arr, true, false);

	$rc = $ans->Result;
	if($rc != "0")
	{
		return "";
	}

	$token = $ans->Token;

	// got successful token, set it's login url
	g1c_TokenStoreValue($token, "SuccessUrl", $passUrl);
	g1c_TokenStoreValue($token, "FailureUrl", $passUrl);

	return $token;
}

?>