<?php
	
	require_once('https_redir.php'); 	

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Account</title>
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
					
						<p class="login_failed">Access Denied.<br/>You must login first!</p>
						<div class="line_4"></div>
						<a href="index.php?p=<?php echo $_GET['p']; ?>" class="login"></a>
					
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
