<?php
	
	require_once('https_redir.php'); 	

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
					<form name="forgotpasswordForm" action="unsubscribe-exec.php" method="post"  >
						
						<p class="send_text">Just enter the email you signed-up with,<br/>and we'll unsubscribe you from our newsletter.<br/>
						
						<?php
							$id = $_GET['id'];
							if ($id == 1) {
							  echo("<p class=\"send_text2\">You have been successfully unsubscribed!</p>");
							} 
							if ($id == 2) {
							  echo("<p class=\"send_text2\">There was a problem.</p>");
							}
							if ($id == 3) {
							  echo("<p class=\"send_text2\">There is no account with that email address.<br/></p>");
							}
						?>
						

						<div class="e-mail_send"><img src="images/e-mail_1.gif"  alt="" border="0px" /></div>
						<div class="form2_send"><input  type="text"  name="email" value="" class="form3_1" /></div>
						<div class="cL"></div>	
					

						<input type="submit" value="" class="send" />
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
