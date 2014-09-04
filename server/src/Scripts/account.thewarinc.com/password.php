<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php');
	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Change Password</title>
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
				<li class="menu_2 active_2"><a href="profile.php"></a></li>
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
				<form name="Search1" action="password-exec.php" method="post"  >
					
					<?php

						$id = $_GET['id'];

						if ($id == 1) {
						  echo("<p class=\"send_text2\">Password Changed Successfully!!</p>");
						} 
						if ($id == 2) {
						  echo("<p class=\"send_text2\">New Passwords do not match.</p>");
						}
						if ($id == 3) {
						  echo("<p class=\"send_text2\">Current Password is incorrect.</p>");
						}
						if ($id == 4) {
						  echo("<p class=\"send_text2\">New Passwords is too short.</p>");
						}							
						
					?>									
										
					<div class="block">	
						
						<div class="password_left" align="right"><img src="images/current_password.gif" alt="" border="0px" /></div>
						<div class="input_password"><input  type="password" id="passwd" name="passwd" value="" class="form_inputpassword" /></div>
						<div class="cL"></div>
					</div>
					<div class="block">
						<div class="password_left2" align="right"><img src="images/new_password.gif" alt="" border="0px" /></div>
						<div class="input_password2"><input  type="password" id="newpasswd" name="newpasswd" value="" class="form_inputpassword" /></div>
						<div class="cL"></div>
					</div>
					<div class="block">
						<div class="password_left2" align="right"><img src="images/confirm_password.gif" alt="" border="0px" /></div>
						<div class="input_password3"><input  type="password" id="newpasswd2" name="newpasswd2" value="" class="form_inputpassword" /></div>
						<div class="cL"></div>
					</div>
					<input type="submit" value="" class="save" />
				</form>
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
