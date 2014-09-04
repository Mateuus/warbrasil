<?php
	session_start();
	require_once('https_redir.php'); 

	require_once('auth_ingame.inc.php');
	ingame_autologin();

	require_once('auth.php');

	require_once('cccountries.inc.php');
	$Is_CC_Allowed = cc_is_country_allowed();
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
		<div class="margin_1">
			<div class="bg_step_on">
				<img src="images/step1_on.gif" alt="" border="0px" />
				<span>SELECT PAYMENT METHOD</span>
			</div>
			<div class="bg_step_off">
				<img src="images/step2_off.gif" alt="" border="0px" />
				<span>select amount</span>
			</div>
			<div class="bg_step_off">
				<img src="images/step3_off.gif" alt="" border="0px" />
				<span>make your purchase</span>
			</div>
			<div class="cL"></div>
		</div>
		<div class="shadow10_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
				<div class="important_notice"></div>
				<p class="text_3">Please Make sure to be logged in to Account Management first. You can not enter this site without playing the game<br/>Make sure to fully read the descriptions of the items before making your purchase<br/>Please select the item of your choice one by one. Some items have a limited purchaseable quantity.<br/>You acknowledge and agree that any applicable fees and other charges for fee-based services (including, without limitation, Game Points (as defined in the full Terms of Use) are payable in advance and not refundable in whole or in part. You are fully liable for all charges to your account, including any unauthorized charges By clicking "PLACE ORDER" button you agree to <a href="http://www.thewarinc.com/terms.html" target="_blank" >Terms of Service</a></p>
				<div class="line_6"></div>	
				<div class="payment_selection"></div>
				<br>
				<?php
					if(isset($_SESSION['GamersfirstID'])) {
						echo("<a href=\"store_g1c.php\" class=\"gamersfirst\"></a><br><br>");
						//echo("<div class=\"cL\"></div>");
					}

					if($Is_CC_Allowed) {
						echo("<a href=\"store_cc.php\" class=\"card\"></a>");
					}
				?>
				<a href="store_paypal.php" class="paypal"></a>	
				<a href="store_sms.php" class="sms"></a>	
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_8"></div></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
