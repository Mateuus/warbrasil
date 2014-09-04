<?php
	session_start();
	
	// remember request id in session var
	if(isset($_GET['requestId']))
		$_SESSION['requestId'] = $_GET['requestId'];

	// bail out if we don't have requestId
	$requestId = $_SESSION["requestId"];
	if(!isset($requestId) || strlen($requestId) < 2)
		die('no requestid');

	$amazon_login_error = $_SESSION['amazon-login-error'];
	unset($_SESSION['amazon-login-error']);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Home Page</title>
<style type="text/css">
body,html{ height:100%; margin:0; padding:0; border:0}
input{ background:none; border:0; width:150px; margin:0}
input[type=submit]{ background:url(img/login_off.jpg); width:90px; margin:20px; cursor:pointer; height:81px;}
input[type=submit]:hover{background:url(img/login_on.jpg);}

input[type=button]{ background:none; border:0; width:0; margin:0; }
input[type=button]{ background:url(img/cancel_off.jpg); width:125px; margin:0; cursor:pointer; height:38px;}
input[type=button]:hover{background:url(img/cancel_on.jpg);}

</style>		

<script type="text/javascript">
function closeWin()
{
 self.close();
}
</script>
 
</head>
<body bgcolor="#1c272d" style="height:100%;">
<table width="100%" height="100%"> 
	<tr valign="middle" >
		<td valign="middle">
			<table align="center" style="margin:0 auto;" width=600>
				<tr>
					<td background="img/bg_main.jpg"   valign="top" height=500 width=600>
  						<form name="Login" action="amazon-login-exec.php" method="post">
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=165><td></td></tr>
							<tr height=81>
								<td width=227></td>
								<td width=155>
									<table width="100%" cellpadding="0" cellspacing="0" >
										<tr height=9><td></td></tr>
										<tr>
											<td><input type="text" name="username" id="username"/></td>
										</tr>
										<tr height=12><td></td></tr>
										<tr>
											<td><input type="password" name="password" id="password"/></td>
										</tr>
										<tr height=10><td></td></tr>
									</table>
								</td>
								<td>
									<input type="submit" value="" name="w" />
								</td>
							</tr>
							<tr height=0><td></td></tr>
						</table>
						</form>
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center" style="font:12px Tahoma; font-weight:bold; color:#ff2525; text-transform:uppercase"><?php
								      if(isset($amazon_login_error)) echo($amazon_login_error); else echo("&nbsp;");
								?></td>
							</tr>
							<tr height=8><td></td></tr>
						</table>
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center" style="font:14px Tahoma; color:#ffffff;">Don’t have an account? Click <a href="amazon-register.php" target="_self" style="font:14px Tahoma; color:#00a8ff;">HERE</a> to register one</td>
						

</table>
<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=30><td></td></tr>
							<tr height=0>
								<td width=230></td>
								<td width=0>
									
								
								<td>
									<input type="button" value="" name="b" onclick="closeWin()"/>
								</td>
							</tr>
							<tr height=6><td></td></tr>



								



						</table>

						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=40><td></td></tr>


								<td align="center" style="font:11px Tahoma; color:#525e66;">Any information provided on this page is provided to Online Warmongers Group, not Amazon
<br> Any information provided is subject to <a href="http://www.thewarinc.com/privacy.html" target="_blank" style="font:11px Tahoma; color:#00a8ff;">Online Warmongers policy</a></td>
							</tr>
						</table>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
							

</body>
</html>
