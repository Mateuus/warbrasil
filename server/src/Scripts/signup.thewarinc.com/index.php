<?php
	session_start();

	$InviteCode = $_GET['id'];

	// legacy Urls
	if($InviteCode == "dis09fbad345")	// REFERID_FBAds2
		$InviteCode = "A1tazmq";
	if($InviteCode == "fdo530AMD")		// REFERID_AMD
		$InviteCode = "A1tazms";
	if($InviteCode == "fileplanet1")	// REFERID_Fplanet
		$InviteCode = "A1tazmu";
	if($InviteCode == "y6txfire1")		// REFERID_XFIRE
		$InviteCode = "A1tazmv";

	$matomy_ce_cid = $_SESSION['matomy_ce_cid'];
	$matomy_ce_pub = $_SESSION['matomy_ce_pub'];

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<?php include('config.php'); ?>
	
	<?php
	
	echo "
	<title>$sitename - $siteinfo</title>";
			
	echo "
	<META http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />
	<META name=\"description\" content=\"$META_Desc\">
	<META name=\"keywords\" content=\"$META_Keywords\">
	";	
	
	?>
	
	<?php include('analytics.php'); ?>
	
	<link href="css/style2.css" rel="stylesheet" type="text/css" />
	
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	
	<script src="js/rollovers.js" type="text/javascript"></script>
	<script src="js/highlight.js" type="text/javascript"></script>
	
	<script src="js/jquery-1.4.3.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="js/jquery.lightbox-0.5.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.lightbox-0.5.css" media="screen" />
	
	<script type="text/javascript" src="js/video.js"></script>
	
	<SCRIPT LANGUAGE="JavaScript">
	
 		function registerAccount() {
		
			error = 0;
			
			var error_username = 0;
			var error_password = 0;
			var error_cpassword = 0;
			var error_email = 0;
			var error_legal = 0;
			
			document.getElementById('error_username').innerHTML = "";
			document.getElementById('error_password').innerHTML = "";
			document.getElementById('error_cpassword').innerHTML = "";
			document.getElementById('error_email').innerHTML = "";
			document.getElementById('error_legal').innerHTML = "";
			

			if (document.registerForm.username.value.length > 16 ) {
			
				error = 1;
				error_username = 1;
				
				document.getElementById('error_username').innerHTML = "<span class='error' >*Username must be less than 16 characters.</span>";
			}
			
			if (document.registerForm.username.value.length < 4 ) {
			
				error = 1;
				error_username = 1;
				
				document.getElementById('error_username').innerHTML = "<span class='error' >*Username too short.  Must be at least 4 characters.</span>";
			}
			
			
			if (/^[a-z0-9]+$/i.test(document.registerForm.username.value) == false ) {
			
				error = 1;
				error_username = 1;
				
				document.getElementById('error_username').innerHTML = "<span class='error' >*Username has illegal characters. Characters must be alpha-numeric.</span>";
			}
			
			if (document.registerForm.username.value == "" ) {
			
				error = 1;
				error_username = 1;
				
				document.getElementById('error_username').innerHTML = "<span class='error' >*You must enter in a username.</span>";
			}
			
			
			
			if (document.registerForm.password.value == "" ) {
			
				error = 1;
				error_password = 1;
				
				document.getElementById('error_password').innerHTML = "<span class='error' >*You must enter in an password.</span>";
			}
			
			if (document.registerForm.password.value.length > 15 ) {
			
				error = 1;
				error_password = 1;
				
				document.getElementById('error_password').innerHTML = "<span class='error' >*Password too long. Must be less than 15 characters.</span>";
			}
			
			if (document.registerForm.password.value.length < 4 ) {
			
				error = 1;
				error_password = 1;
				
				document.getElementById('error_password').innerHTML = "<span class='error' >*Password too short.  Must be at least 4 characters.</span>";
			}
			
			if (document.registerForm.password.value == "" ) {
			
				error = 1;
				error_password = 1;
				
				document.getElementById('error_password').innerHTML = "<span class='error' >*You must enter in an password.</span>";
			}
			
			
			
			if (document.registerForm.cpassword.value != document.registerForm.password.value ) {
			
				error = 1;
				error_cpassword = 1;
				
				document.getElementById('error_cpassword').innerHTML = "<span class='error' >*Passwords do not match.</span>";
			}
			
			if (document.registerForm.cpassword.value == "" ) {
			
				error = 1;
				error_cpassword = 1;
				
				document.getElementById('error_cpassword').innerHTML = "<span class='error' >*You must confirm your password.</span>";
			}
			
			if (/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/.test(document.registerForm.email.value) == false ) {
			
				error = 1;
				error_email = 1;
				
				document.getElementById('error_email').innerHTML = "<span class='error' >*Must be a valid email address.</span>";
			}
			
			if (document.registerForm.email.value == "" ) {
			
				error = 1;
				error_email = 1;
				
				document.getElementById('error_email').innerHTML = "<span class='error' >*You must enter in your email address.</span>";
			}
			
			
			if (document.registerForm.legal.checked == false ) {
			
				error = 1;
				error_legal = 1;
				
				document.getElementById('error_legal').innerHTML = "<span class='error' >*You must accept the terms.</span>";
			
			}
			
			
			
			if (error == 0) {
			
				document.registerForm.submit();
				//alert('Register Account')

			}
			else {
				
				document.getElementById('FormErrors').style.display = "block";
			}
		
		
		
		}
	
	</script>

<script type="text/javascript" src="http://static.meteorsolutions.com/
metsol.js"></script>
<script type="text/javascript">
meteor.tracking.track('0f1bf8c6-747e-4316-934b-13e02ce1e0e8');
meteor.orion.init();
</script>


</head>	

<body>

<!--Video Pop Up-->	
<div id="VideoPopUp" align="center" style="display: none; position: absolute; top: 200px; left: 0px; z-index: 900; width: 100%;" >
	
	<div style="width: 670px; height: 430px; padding: 0px;z-index: 900; background-color: #000000; border: 1px solid #000;" >
	
		<div align="right" style="padding: 5px;" >
			<a href="Javascript: HideVideo();" >Close</a>
		</div>
		
		<div id="YouTubePlayer" >

		</div>
		
		
	</div>
	
</div>

<!--Overlay-->
<div id="VideoOverlay" style="display: none; position: absolute; top: 0px; left: 0px; z-index: 800; background: url('images/gray.png') repeat; width: 100%; height: 2300px;" >
</div>

<script type="text/javascript">		

	$(document).ready(function() {

		$('#gallery a').lightBox();

	});
			 
</script>

<!--Outer Div-->
<div style="position: relative; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100;" align="center" >
					
	<!--Container Div-->
	<div style="width: 1024px; z-index: 100;" align="left" >
	
		<!--Banner-->
		<div style="z-index: 105;" >
			<img src="images/Banner.png" border="0" >
		</div>
		
		<!--Middle-->
		<div style="position: relative; top: 0px; left: 0px; width: 100%; z-index: 100;" >
		
			<!--Error Text-->
			<div id="FormErrors" style="position: absolute; top: 50px; left: 460px; width: 700px; z-index: 300; display: none;" >

				<div style="position: absolute; top: 10px; left: 500px;" id="error_username"></div>		
				<div style="position: absolute; top: 45px; left: 500px;" id="error_password"></div>
				<div style="position: absolute; top: 75px; left: 500px;" id="error_cpassword"></div>
				<div style="position: absolute; top: 110px; left: 500px;" id="error_email"></div>
				<div style="position: absolute; top: 170px; left: 40px;" id="error_legal"></div>
			</div>
			
		
			<!--Left Side -->
			<div style="position: absolute; top: -20px; left: -60px; z-index: 110" align="left" >
				
				<div style="position: absolute; top: -30px; left: 50px; z-index: 110" >
					<a href="http://thewarinc.com" >
						<img src="images/WarIncLogo3.png" border="0" width="500" >
					</a>
				</div>
				
				
					
				
				
				<div style="position: absolute; top: 320px; left: 150px; width: 260; z-index: 150" align="center" >	
					<a href="Javascript: ShowVideo('pQDsThft7FU');" >
						<img src="images/TrailerButton1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GO2','','images/TrailerButton2.png',1)" id="GO2" name="GO2" >
					</a>
				</div>
			
				
				
				<div style="position: absolute; top: 410px; left: 110px; width: 342; z-index: 150" align="center" >	
					<?php
					echo "<a href=\"overview.php?id=" . $InviteCode . "\">";
					?>
						<img src="images/GameOverview1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GO1','','images/GameOverview2.png',1)" id="GO1" name="GO1" >
					</a>
				</div>
				
					
				<div style="position: absolute; top: 510px; left: 80px; width: 485px; height: 148px; z-index: 150; background:url('images/RequirementsBG.png') no-repeat;"	>
				
					&nbsp;&nbsp;&nbsp;<span class="text_ReqTitle" >Minimum System Requirements:</span><br>
					
					
					<table style="margin-left: 20px;" >
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						OS:
						</td>
						<td align="left" valign="top" class="text_Req2" >
						&nbsp;&nbsp;Windows XP SP3 or higher
						</td>
					  </tr>
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						CPU:
						</td>
						<td align="left" valign="top" class="text_Req2" >
						&nbsp;&nbsp;Intel Core 2 Duo 1.8GHz or similar AMD
						</td>
					  </tr>
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						RAM:
						</td>
						<td align="left" valign="top" class="text_Req2" >
						&nbsp;&nbsp;2GB of RAM
						</td>
					  </tr>
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						HDD:
						</td>
						<td align="left" valign="top" class="text_Req2" height="10px" >
						&nbsp;&nbsp;2GB of HDD space
						</td>
					  </tr>
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						VIDEO:
						</td>
						<td align="left" valign="top" class="text_Req2" >
						&nbsp;&nbsp;nVidia 9600 or similar ATI, 512MB dedicated video memory
						</td>
					  </tr>
					  <tr style="float:left; height:15px; width: 100%;" >
					    <td align="right" valign="top" width="50" class="text_Req" >
						VIDEO:
						</td>
						<td align="left" valign="top" class="text_Req2" >
						&nbsp;&nbsp;Pixel shaders 3.0
						</td>
					  </tr>
					</table>

					
				
				
				</div>
				

				
				

		

			</div>
			
			<!--Right Side -->
			<div style="position: absolute;  padding: 45px; top: 0px; left: 455px; width: 578px; height: 604px; z-index: 20; background:url('images/PlateBGb.png') no-repeat;" align="left" >
		
				<div style="width: 485px; height: 199px; z-index: 20; background:url('images/RegisterBG.png') no-repeat;"	>

					<form id="registerForm" name="registerForm" method="post" action="http://account.thewarinc.com/register-exec.php">
							
					<table style="margin-left: 170px; padding-top: 10px;" >
					  <tr>
					    <td>
							<input name="username" type="text" class="textfield" id="username" value=""  />										  
					    </td>
					  </tr>
					  <tr>
						<td>
							<input name="password" type="password" class="textfield" id="password" value=""  />										 
						</td>
					  </tr>
					  <tr>
						<td>
							<input name="cpassword" type="password" class="textfield" id="cpassword" value=""  />										 
						</td>
					  </tr>
					  <tr>
						<td>
							<input name="email" type="text" class="textfield" id="email" value=""  />										 
						</td>
					  </tr>
					  <tr>
						<td>
							<input name="invitecode" type="text" class="textfield" id="invitecode" value=""  />										 
						</td>
					  </tr>
					</table>

					<br>
					
					<input type="checkbox" name="legal" value="legal" /> 
					<span class="text_legal" style="color: #FFFFFF !important;" >By Checking the box, you confirm that:<br>
					You agree to the <a href="<?php echo $TOS_Link; ?>" target="_blank" class="legalLink" >Terms of Service</a> and <a href="<?php echo $PrivacyPolicy_Link; ?>" target="_blank" class="legalLink" >Privacy Policy</a>.	 <br>
					</span>

					<input name="inviteKey" type="hidden" value="<?php echo $InviteCode; ?>">

					<input name="matomy_ce_cid" type="hidden" value="<?php echo $matomy_ce_cid; ?>">
					<input name="matomy_ce_pub" type="hidden" value="<?php echo $matomy_ce_pub; ?>">

					</form> 
				
				</div>
				
				<br><br>
				
				<a href="javaScript:registerAccount()" 
onClick="meteor.tracking.track_conversion('0f1bf8c6-747e-4316-934b-
13e02ce1e0e8',{'name':'myconversion2'}, this);">
<img src="images/PlayFree1.png" style="margin-left: 25px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Register1','','images/PlayFree2.png',1)" id="Register1" name="Register1" ></a><br>
				
				<br>
				
	
				<table width="100%" >
				  <tr>
					<td width="20" >
					</td>
				    <td width="150" >
						<br>
						<a href="http://www.fileplanet.com/219380/210000/fileinfo/War-Inc.-Battle-Zone-Client-%28Free-Game%29" target="_blank" >
						<img src="images/Logo_GameSpy2.png" border="0" width="150" >
						</a>
					</td>
					<td align="left" >
						
						<div style="float: left; width: 150px; margin-top: -40px;" align="center" >
						Download on<br>
						<a href="http://www.xfire.com/downloads/3731/" target="_blank" >
						<img src="images/xfirelogo.png" border="0" width="140" >
						</a>
						</div>
						
						<div style="float: left; width:  150px; margin-top: -40px;" align="center" >
						Download on<br>
						<a href="http://www.fileplanet.com/219380/210000/fileinfo/War-Inc.-Battle-Zone-Client-%28Free-Game%29" target="_blank" >
						<img src="images/Logo_FilePlanet.png" border="0" width="140" >
						</a>
						</div>
						
						<div style="clear: both;" ></div>
						
						<br>
						
						<div style="margin-left: 10px; width: 250px;" align="left" >
							“War Inc. is the sort of shooter that might save you the $50 you would have spent on Call of Duty.” -GameSpy
						</div>
					</td>
				  </tr>
				</table>

				
				<br>
				
				<div style="width: 100%; margin-left: -20px;" align="center" >
					<img src="images/SteamWarning2.png" border="0" width="400" >
				</div>
					
					
		
					
		
				
			
			</div>
			
			
			<!--Bottom-->
			<div align="center" style="position: absolute; top: 600px; left: 0px; height: 206px; width: 1023px; background: url('images/ScreenshotsBG.png') no-repeat;" >
				
				<!--Screenshots-->
				<div style="margin-left: 20px;" >
				
				<br><br><br>
				
				<div id="gallery">
				
				<div style="float: left; margin-top: -8px; width: 80px; visibility: hidden;" >
				<a href="#" ><img src="images/ArrowL1.png" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('AL1','','images/ArrowL2.png',1)" id="AL1" name="AL1" ></a>
				</div>
				
				<?php
				
					include('screenshots.php');
				
					for ($i=0;$i<5;$i++) {
					
						echo "
							<div style=\"position: relative; float: left; width: 170px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"Media/Screenshots/$myScreenShots[$i]\" rel=\"lightbox[media]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"Media/Screenshots/$myScreenShots_resize[$i]\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
					
					}
					
					
				
				
				?>
				
					<div style="float: left; margin-top: -8px; margin-left: -20px; visibility: hidden;" >
					<a href="#" ><img src="images/ArrowR1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('AR1','','images/ArrowR2.png',1)" id="AR1" name="AR1" ></a>
					</div>
					
					<div style="clear: both;" ></div>
				
				</div>
				
					
					
				</div>
			
				<br>
				
				<!--Footer-->
				<div align="center" style="z-index: 100; " >				
					
					<img src="images/hl.png" border="0" > <br>
					
					<table width="800px" align="center" style="margin-top: 5px;" >
					  <tr>
					    <td>
						
							<img src="images/WarmongersLogo2.png" border="0" ><br>

						</td>
						<td>
						
						<img src="images/GamingEvolved.png" border="0" height="80" >
						
						</td>
						<td style="color: #66ccff;" >
						
							<a href="http://support.thewarinc.com/">Support</a> | 
							<a href="http://www.thewarinc.com/privacy.html">Privacy Policy</a> |
							<a href="http://www.thewarinc.com/Terms.html">Terms of Use</a>	
						
						</td>
						<td class="text_footer" >
										
							&copy; Online Warmongers Group, inc. All rights reserved.<br>
						
<script type="text/javascript" src="http://static.meteorsolutions.com/
metsol.js"></script>
<script type="text/javascript">
meteor.sharing.tool('0f1bf8c6-747e-4316-934b-
13e02ce1e0e8',{'sites':'email,facebook,twitter,live'});
</script>
							
						
						</td>
					  </tr>
					</table>
					
					<br>
			
					
				</div>

			</div>
			
	
		</div>

	</div>	

</div>









</body>
</html>
