<?php
	session_start();
	
	// remember request id in session var
	if(isset($_GET['requestId']))
		$_SESSION['requestId'] = $_GET['requestId'];

	// bail out if we don't have requestId
	$requestId = $_SESSION["requestId"];
	if(!isset($requestId) || strlen($requestId) < 2)
		die('no requestid');

	// combine single error string
	$register_error = "";
	if(isset($_SESSION['Error_Username'])) {
		$register_error = $_SESSION['Error_Username'];
	}
	if(isset($_SESSION['Error_Password'])) {
		if($register_error != "")
			$register_error .= ", ";
		$register_error .= $_SESSION['Error_Password'];
	}
	if(isset($_SESSION['Error_Email'])) {
		if($register_error != "")
			$register_error .= ", ";
		$register_error .= $_SESSION['Error_Email'];
	}
	if(isset($_SESSION['Error_Legal'])) {
		if($register_error != "")
			$register_error .= ", ";
		$register_error .= $_SESSION['Error_Legal'];
	}
	if($register_error == "")
		$register_error = "&nbsp;";

	unset($_SESSION['Error_Username']);
	unset($_SESSION['Error_Password']);
	unset($_SESSION['Error_Email']);
	unset($_SESSION['Error_Legal']);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Home Page</title>
<style type="text/css">
body,html{ height:100%; margin:0; padding:0; border:0}
input{ background:none; border:0; width:150px; margin:0}
input[type=submit]{ background:url(img/reg_off.jpg); width:90px; margin:0; cursor:pointer; height:139px;}
input[type=submit]:hover{background:url(img/reg_on.jpg);}

input[type=button]{ background:none; border:0; width:0; margin:0; }
input[type=button]{ background:url(img/cancel_off.jpg); width:125px; margin:0; cursor:pointer; height:38px;}
input[type=button]:hover{background:url(img/cancel_on.jpg);}

input[type=checkbox]{ background:none; border:0; width:13px; margin:0;}

</style>		

<script type="text/javascript">
function closeWin()
{
 self.close();
}
</script>

</head>
<body bgcolor="#1d262d" style="height:100%;">
<table width="100%" height="100%"> 
	<tr valign="middle" >
		<td valign="middle">
			<table align="center" style="margin:0 auto;" width=600>
				<tr>
					<td background="img/bg_reg_main.jpg"   valign="top" height=500 width=600>
						<form id="registerForm" name="registerForm" method="post" action="../register-exec.php">
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=155><td></td></tr>
							<tr height=100>
								<td width=260></td>
								<td width=175>
									<table width="100%" cellpadding="0" cellspacing="0" >
										<tr height=0<td></td></tr>
										<tr>
						<td>
							<input name="username" type="text" class="textfield" id="username" value="<?php echo $_SESSION['username']; ?>"  />
						</td>
										</tr>
										<tr height=12><td></td></tr>
										<tr>
						<td>
							<input name="password" type="password" class="textfield" id="password" value="<?php echo $_SESSION['password']; ?>"  />
						</td>
										</tr>
<tr height=12><td></td></tr>
										<tr>
						<td>
							<input name="cpassword" type="password" class="textfield" id="cpassword" value="<?php echo $_SESSION['cpassword']; ?>"  />
						</td>
										</tr>
<tr height=12><td></td></tr>
										<tr>
						<td>
							<input name="email" type="text" class="textfield" id="email" value="<?php echo $_SESSION['email']; ?>"  />
						</td>
										</tr>
										<tr height=0><td></td></tr>
									</table>
								</td>
								<td>
									<input type="submit" value="" name="w" onClick="this.disabled=true; document.registerForm.submit();" />
								</td>
							</tr>
							<tr height=12><td></td></tr>



							





						<input name="inviteKey" type="hidden" value="A1tjars">
						<input name="legal" type="hidden" value="checked">
						</form>
						</table>

<table width="80%" cellpadding="0" cellspacing="0" >
<tr height=0><td></td></tr>
							
								<td width=103></td>
								<td width=0>
							

<input type="checkbox" name="option1" value="a1" checked>
</td>
	
							
								<td align="center" style="font:14px Tahoma; color:#ffffff;">By Checking the box, you confirm that you agree to<br> the <a href="http://www.thewarinc.com/terms.html" target="_blank" style="font:14px Tahoma; color:#00a8ff;">Terms of Service</a> and <a href="http://www.thewarinc.com/privacy.html" target="_blank" style="font:14px Tahoma; color:#00a8ff;">Privacy Policy</a></td>
</tr>
							<tr height=15><td></td></tr>

</table>
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center" style="font:12px Tahoma; font-weight:bold; color:#ff2525; text-transform:uppercase">
									<?php echo($register_error); ?>
								</td>
							</tr>
							<tr height=8><td></td></tr>
					

</table>
						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center" style="font:14px Tahoma; color:#ffffff;">Already have an account? Click <a href="amazon-login.php" target="_self" style="font:14px Tahoma; color:#00a8ff;">HERE</a> to login</td>
							</tr>
						</table>
<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=10><td></td></tr>
							<tr height=0>
								<td width=235></td>
								<td width=0>
									
								
								<td>
									<input type="button" value="" name="b" onclick="closeWin()"/>
								</td>
							</tr>
							<tr height=6><td></td></tr>



								



						</table>

						<table width="100%" cellpadding="0" cellspacing="0" >
							<tr height=10><td></td></tr>


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
