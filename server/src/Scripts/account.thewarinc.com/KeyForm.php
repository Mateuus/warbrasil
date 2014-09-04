<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 

	$CustomerID = $_SESSION['CustomerID'];
	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Redeem Code</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->

<style type="text/css">
html,
body {
background-color: transparent;
background-image: none;
bgcolor="transparent"> 
}
</style>

<script type="text/javascript" src="js/rollovers.js"></script>	

</head>
<body>


	



				
<p class="text_2">If you have code from PAX2011, pre-paid card, digital pack or promo code, please enter code here and press activate. The Items from the code will be added to your account immediately. </p>
<form name="activate" action="key-exec.php" method="post"  >
	<?php
	echo "<input name=\"userid\" type=\"hidden\" value=\"$CustomerID\"  >";
	?>
	<div class="input4"><input  type="text" name="coupon" id="coupon" value="" class="form_ind6" /></div>
	<div class="cL"></div>	
	<div class="line_9"></div>		
	<a href="javaScript:document.activate.submit()" ><img src="images/activate_off.gif" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Login1','','images/activate_on.gif',1)" id="Login1" name="Login1" ></a>
</form>
			
			

</body>
</html>

