<?php
	require_once('geo_redir.php');
	
	require_once('https_redir.php'); 

	session_start();

	require_once('auth_ingame.inc.php');
	ingame_autologin();
	
	
	if(isset($_SESSION['CustomerID'])) {
		header("location: home.php");
		exit();
	} 

	if(!isset($_SESSION['invitecode'])) {
		$_SESSION['invitecode'] = '111U-YG5H-KGGK-MCAJ';
	}
	

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Account Management</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->
<script type="text/javascript" src="js/analytics.js"></script>
<SCRIPT TYPE="text/javascript">
	<!--
	function submitenter(myfield,e)
	{
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;

	if (keycode == 13)
	   {
	   myfield.form.submit();
	   return false;
	   }
	else
	   return true;
	}
	//-->
</SCRIPT>

</head>
<body>
<div class="main_bg1">
	<div class="main_bg">&nbsp;</div>
</div>
<div class="root">							
<!-- BEGIN BODY -->


	
<!-- BEGIN HEADER -->

	
	
<!-- HEADER EOF   -->	

<!-- BEGIN CONTENT -->

	<div id="content">
		<a href="index.php"   class="logo_2"></a>
		<div class="shadow7_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
				<div class="img_1">
					<form name="Login" action="login-exec.php" method="post"  >
						<div class="e-mail"><img src="images/id.gif"  alt="" border="0px" /></div>
						<div class="form2"><input  type="text"  name="username" id="username" value="" class="form3" /></div>
						<div class="cL"></div>	
						<div class="password"><img src="images/password.gif"  alt="" border="0px" /></div>
						<div class="form4"><input type="password" id="password"  name="password" value="" class="form3" /></div>
						<div class="cL"></div>	
						<a href="pwdreset1.php" class="forgot_password">Forgot your password?</a>
						<div class="cL"></div>	
						<div class="line_4"></div>
						<p class="register">Don't have an account ? Click <a href="http://signup.thewarinc.com/?id=A1tg2tj">here</a> to register one</p>
						<?php
						if (isset($_GET['p'])) {
							$CurrentURL = $_GET['p'];
							echo "<input type='hidden' id='page'  name='page' value='$CurrentURL'  />";
						}	
						
						?>
						<input type="submit" value="" class="login" />
					</form>
				</div>
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
