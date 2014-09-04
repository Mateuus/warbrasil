<?php
	session_start();
	require_once('https_redir.php'); 

	require_once('auth.php'); 
	
	require_once('store.inc.php');
	require_once('store_g1c.inc.php');

	if(!isset($_SESSION['GamersfirstID']))
		die('fraud');

	$CustomerID = $_SESSION['CustomerID'];

	$G1Balance = g1c_GetBalance();

	function show_item_row2($itemid,$itemInfo1,$itemInfo2,$itemInfo3)
	{
		// get item price and desc
		list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($itemid, 3);
		global $CustomerID;
		$g1cost = g1c_GCtoG1C($x_price);
		
		echo "
			<a href=\"Store_g1c_confirm.php?ItemID=$itemid\" class=\"bg_select_amount\">
				<span class=\"img_2\"></span>
				<span class=\"number_1\">$itemInfo1</span>
				<span class=\"cL\"></span>
				<span class=\"line_ind8\"></span>
				<span class=\"name_1\">$itemInfo2</span>
				<span class=\"name_2\">$itemInfo3</span>
				<span class=\"line_ind8\"></span>
				<span class=\"price\">$g1cost G1C</span>
			</a>
			";
	
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
		<div class="margin_1">
			<a href="store.php" class="bg_step_off2">
				<img src="images/step1_off.gif" alt="" border="0px" />
				<span>SELECT PAYMENT METHOD</span>
			</a>
			<div class="bg_step_on">
				<img src="images/step2_on.gif" alt="" border="0px" />
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
				<div class="left_block1">
					<div class="shadow8_top"></div>	
					<div class="shadow8_repeat">
						<div class="block_current_balance">
							<div><img src="images/current_balance.gif" alt="" border="0px" /></div>
							<div class="line_8"></div>
							<h1><?php echo "$G1Balance G1 Credits"; ?></h1>
						</div>
					</div>
					<div class="shadow8_bottom"></div>
				</div>
					<span></span>
				<div class="cL"></div>

				<div class="padding2">				
					<?php show_item_row2('G1C_GPX4','4,000','4,000 GOLD CREDITS',''); ?>
					<?php show_item_row2('G1C_GPX10','10,000','10,000 GOLD CREDITS',''); ?>
					<?php show_item_row2('G1C_GPX20','20,000','20,000 GOLD CREDITS',''); ?>						
					<?php show_item_row2('G1C_GPX30','30,000','30,000 GOLD CREDITS',''); ?>
					<?php show_item_row2('G1C_GPX50','50,000','50,000 GOLD CREDITS',''); ?>
					
					<div class="cL"></div>	
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
