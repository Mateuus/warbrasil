<?php
	
	session_start();
	require_once('http_redir.php'); 
	require_once('auth.php'); 	

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Download</title>
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
		<div class="shadow7_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
			
				<a href="http://hwcdn.thewarinc.com/install/WarInc_WebSetup.exe" class="download_game" style="margin-top: -20px;"></a>
				
				<!--<div align="center"><p class="bold">Do you know that you can launch game from Windows Start menu ?<br/>You don't need use web launcher or website to play game !<br/>Just launch game from either Start menu or by clicking War Inc Battlezone icon on desktop !</p></div>
				<div class="line_6"></div>-->
				<br>
				<p class="name_category">Minimum System Requirements ( 30fps on LOW in 1280x720 ):</p>
				<p class="name_category_inf">
					<span>OS: </span> Windows XP SP3 or higher<br/> 
					<span>CPU: </span> Intel Core 2 Duo 1.8GHz or similar AMD<br/> 
					<span>RAM:</span> 2GB of RAM<br/> 
					<span>HDD: </span> 2GB of HDD space<br/> 
					<span>VIDEO: </span> nVidia 9600 or similar ATI, 512MB dedicated video memory <br/> 
					<span>VIDEO: </span> Pixel shaders 2.0  
				</p>
				<div class="line_6"></div>
				<p class="name_category">Recommended System Requirements ( 60fps on HIGH in 1920x1080 ):</p>
				<p class="name_category_inf">
					<span>OS: </span> Windows XP SP3 or higher<br/> 
					<span>CPU: </span> Intel Core 2 Duo 3.0GHz or similar AMD<br/> 
					<span>RAM:</span> 4GB of RAM<br/> 
					<span>HDD: </span> 2GB of HDD space <br/> 
					<span>VIDEO: </span> nVidia 570 or similar ATI, 1GB dedicated video memory <br/> 
					<span>VIDEO: </span> Pixel shaders 2.0  
				</p>
				<div class="line_6"></div>
				<!--<p class="name_category">ALternative download links:</p>
				
				
				
				<a href="http://www.fileplanet.com/219380/210000/fileinfo/War-Inc.-Battle-Zone-Client-%28Free-Game%29" class="alternative_link" target="_blank" >DOWNLOAD FROM FILEPLANET</a><br/> 				
				<a href="http://www.xfire.com/downloads/3731/" class="alternative_link" target="_blank">DOWNLOAD FROM X-FIRE</a><br/>
				<a href="http://www.strategyinformer.com/pc/warincbattlezone/full-game/42058.html" class="alternative_link" target="_blank">DOWNLOAD FROM Strategy Informer</a><br/>
				<a href="http://www.ausgamers.com/files/details/html/62918" class="alternative_link" target="_blank">DOWNLOAD FROM AusGamers</a><br/> <br/>
				-->
				
				
							
			
			
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_6"></div></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
