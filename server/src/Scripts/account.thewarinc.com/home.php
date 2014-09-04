<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Home</title>
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
				<li class="menu_1 active_1"><a href="home.php"></a></li>
				<li class="menu_2"><a href="profile.php"></a></li>
				<li class="menu_3"><a href="invitefriends.php"></a></li>
				<li class="menu_4"><a href="key.php"></a></li>
				<li class="menu_5"><a href="store.php"></a></li>
				<li class="menu_6"><a href="earn.php"></a></li>
				<li class="menu_7"><a href="history.php"></a></li>
			</ul>
			<div class="cL"></div>
		</div>
	</div>
	
<!-- HEADER EOF   -->	

<!-- BEGIN CONTENT -->

	<div id="content">
		<div class="shadow_1">
			<a href="download.php" class="download_game_off"></a>
			<div class="bottom_1"></div>
		</div>	
		<div class="shadow_3">
			<a href="invitefriends.php" class="invite_friends_off"></a>
			<div class="bottom_2"></div>
		</div>	
		<div class="cL"></div>	
		<div class="line_1"></div>	
		<div class="shadow2_top"><img src="images/name_1.png"  alt="" border="0px" /></div>	
		<!--<div class="shadow2_repeat"><a href="store.php"><img src="images/hot_offer.jpg"  alt="" border="0px" /></a> </div>-->
		<div class="shadow2_bottom"></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
