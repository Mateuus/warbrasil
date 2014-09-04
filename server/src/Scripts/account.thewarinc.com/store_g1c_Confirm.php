<?php
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 
	
	require_once('store.inc.php');
	require_once('store_g1c.inc.php');

	if(!isset($_SESSION['GamersfirstID']))
		die('fraud');

	$CustomerID = $_SESSION['CustomerID'];

	// get item price and desc
	$x_id = $_REQUEST['ItemID'];
	list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($x_id, 3);

	$g1Cost    = g1c_GCtoG1C($x_price);
	$g1Balance = g1c_GetBalance($x_price);

	$g1Token   = "";
	if($g1Cost > $g1Balance)
		$g1Token = g1c_GenerateToken("http://www.gamersfirst.com/marketplace/get_g1c.php");

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

	<script language="JavaScript">
		function gotostore()
		{	
			window.location.href = "https://account.thewarinc.com/Store.php";
		}
	</script>

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
		<div class="margin_1">
			<a href="store.php" class="bg_step_off2">
				<img src="images/step1_off.gif" alt="" border="0px" />
				<span>SELECT PAYMENT METHOD</span>
			</a>
			<a href="Store_g1c.php" class="bg_step_off2">
				<img src="images/step2_off_2.gif" alt="" border="0px" />
				<span>select amount</span>
			</a>
			<div class="bg_step_on">
				<img src="images/step3_on.gif" alt="" border="0px" />
				<span>make your purchase</span>
			</div>
			<div class="cL"></div>
		</div>

		<div class="shadow10_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">

				<form action="Store_g1c_MakePurchase.php" name="storeform" method="post">
					<div class="order_info"></div>	
					<div class="item"><?php echo $Item_Desc; ?></div>	
					<div class="price_1">
<?php
	//if($g1Cost < 1000) echo $g1Cost;
	//else               echo (int)($g1Cost / 1000) . "," . $g1Cost % 1000;
	echo "$g1Cost G1 Credits";

	if($g1Cost > $g1Balance) 
	{
		$url = "http://www.gamersfirst.com/marketplace/get_g1c.php";
		if(isset($g1Token) && strlen($g1Token) > 1)
			$url = "https://www.gamersfirst.com/action/sso.php?id=$g1Token";

		echo "<font color=\"#8B0000\"><br>You don't have enough G1 Credits</font>";
		echo "&nbsp;-&nbsp;Please click <a link href=\"$url\" target=\"_blank\" onclick=\"gotostore();\">HERE</a> to refill.<br><br>";
	}
?>
					</div>	
					<div class="line_6"></div>
<?php
	if($g1Cost <= $g1Balance)
					echo("<input type=\"button\" value=\"\" onClick=\"this.disabled=true; document.storeform.submit();\" class=\"place_order\" />");
?>
					<input type="hidden" name="ItemID" value="<?php echo $x_id; ?>"/>
				</form>	
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
