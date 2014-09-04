<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 
	
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

	<script type="text/javascript" src="js/jquery-1.4.3.min.js"></script>
    <script type="text/javascript" src="js/jquery.iframe-auto-height.plugin.js"></script>
	
	<script type="text/javascript" src="js/analytics.js"></script>

	
</head>
<body>

<?php
	//
	// check if we're blocked from processing transaction
	// 

	require_once('dbinfo.inc.php');

	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_PROCESSTRANSACTION_CHECK ?, ?";
	$params = array($CustomerID, 0);
	$member = db_exec($conn, $tsql, $params);

	if($member['Blocked'] > 0)
	{
		echo("<span style=\"font-size: 16px; color:red\">");
		echo("<br>");
		echo("<center>");

		echo("Your last transaction was declined.<br>Please wait a few minutes before using our store.");

		echo("</center>");
		echo("</span>");
		echo("</body>");
		echo("</html>");
		exit();
	}
?>


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
			<a href="store_cc.php" class="bg_step_off2">
				<img src="images/step2_off_2.gif" alt="" border="0px" />
				<span>select amount</span>
			</a>
			<div class="bg_step_on">
				<img src="images/step3_on.gif" alt="" border="0px" />
				<span>make your purchase</span>
			</div>
			<div class="cL"></div>
		</div>
		
		<!--<div class="shadow10_top"></div>	
			<div class="shadow10_repeat">
				<div class="bg_login">-->
				
				<iframe allowtransparency="true" src="Store_OrderInfo.php?ItemID=<?php echo $_GET['ItemID']; ?>" frameborder="0" width="100%" height="800" scrolling="no" name="storeframe" id="storeframe">You need a Frames Capable browser to view this content.</iframe>
				<script>
					//$('#storeframe').iframeAutoHeight({minHeight: 800});
				</script>
				
				<!--</div>
			</div>
		<div class="shadow10_bottom"><div class="bottom_8"></div></div>-->
				
			
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
