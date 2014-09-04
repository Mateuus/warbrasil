<?php
	
	require_once('https_redir.php'); 	

?>
<?php
	
	$token = $_REQUEST["token"];
	if(!isset($token))
		die('token');
	
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
					
					<form id="pwdSetForm" name="pwdSetForm" method="post" action="pwdreset2-exec.php">
					
						<input name="token" type="hidden" value="<?php echo $token; ?>">
					
						<div style="height: 100px; padding-top: 30px;" >
							<?php

								$id = $_GET['id'];							
								
								if ($id == 1) {
								  echo("<p class=\"send_text2\">Password Changed Successfully!!</p>");
								} 
								if ($id == 2) {
								  echo("<p class=\"send_text2\">New Passwords do not match.</p>");
								}
								if ($id == 3) {
								  echo("<p class=\"send_text2\">Passwords does not match.</p>");
								}
								if ($id == 4) {
								  echo("<p class=\"send_text2\">New Password is too short.</p>");
								}								
								
							?>			
						</div>
						<div class="block">
							<div class="password_left2" align="right"><img src="images/new_password.gif" alt="" border="0px" /></div>
							<div class="input_password2"><input  type="password" id="newpwd1" name="newpwd1" value="" class="form_inputpassword" /></div>
							<div class="cL"></div>
						</div>
						<div class="block">
							<div class="password_left2" align="right"><img src="images/confirm_password.gif" alt="" border="0px" /></div>
							<div class="input_password3"><input  type="password" id="newpwd2" name="newpwd2" value="" class="form_inputpassword" /></div>
							<div class="cL"></div>
						</div>
						<input type="submit" value="" class="save" />
						
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
