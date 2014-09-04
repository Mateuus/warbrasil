<?php
	require_once('geo_redir.php'); 
	
	//we can't use https because of http images from thewarinc.com
	//require_once('https_redir.php'); 
	
	session_start();
	
	// remember invite key in session var
	if(isset($_GET['id']))
		$_SESSION['inviteKey'] = $_GET['id'];
	$InviteCode = $_SESSION['inviteKey'];

	// remember sid (used in blind ferret campaing)
	if(isset($_GET['sid']))
		$_SESSION['reg_sid'] = $_GET['sid'];

	// legacy Urls
	if($InviteCode == "dis09fbad345")	// REFERID_FBAds2
		$InviteCode = "A1tazmq";
	if($InviteCode == "fdo530AMD")		// REFERID_AMD
		$InviteCode = "A1tazms";
	if($InviteCode == "fileplanet1")	// REFERID_Fplanet
		$InviteCode = "A1tazmu";
	if($InviteCode == "y6txfire1")		// REFERID_XFIRE
		$InviteCode = "A1tazmv";

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>War Inc. Battlezone - Signup</title>	

	<script type="text/javascript" src="js/analytics.js"></script>
	
	<link href="signup/css/style3.css" rel="stylesheet" type="text/css" />
	
	<link rel="shortcut icon" href="signup/images/favicon.ico" type="image/x-icon" />
	
	<script src="signup/js/rollovers.js" type="text/javascript"></script>
	<script src="signup/js/highlight.js" type="text/javascript"></script>
	
	<script src="signup/js/jquery-1.4.3.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="signup/js/jquery.lightbox-0.5.min.js"></script>
    <link rel="stylesheet" type="text/css" href="signup/css/jquery.lightbox-0.5.css" media="screen" />
	
	<script type="text/javascript" src="signup/js/video.js"></script>
	
	<script type="text/javascript" src="signup/js/register.js"></script>
	
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
<div id="VideoOverlay" style="display: none; position: absolute; top: 0px; left: 0px; z-index: 800; background: url('signup/images/gray.png') repeat; width: 100%; height: 2300px;" >
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
			<img src="signup/images/Banner.png" border="0" >
		</div>
		
		<!--Middle-->
		<div style="position: relative; top: 0px; left: 0px; width: 100%; z-index: 100;" >
		
			<!--Error Text-->
			<div id="FormErrors" style="position: absolute; top: 50px; left: 460px; width: 700px; z-index: 300; <?php if(isset($_SESSION['Error_Username']) || isset($_SESSION['Error_Password']) || isset($_SESSION['Error_Email']) || isset($_SESSION['Error_Legal'])) { echo "display: block;"; } else { echo "display: none;"; }?>" >

				<div style="position: absolute; top: 10px; left: 500px;" id="error_username"><?php echo "<span class='error' >" . $_SESSION['Error_Username'] . "</span>"; ?></div>		
				<div style="position: absolute; top: 45px; left: 500px;" id="error_password"><?php echo "<span class='error' >" . $_SESSION['Error_Password'] . "</span>"; ?></div>
				<div style="position: absolute; top: 75px; left: 500px;" id="error_cpassword"></div>
				<div style="position: absolute; top: 110px; left: 500px;" id="error_email"><?php echo "<span class='error' >" . $_SESSION['Error_Email'] . "</span>"; ?></div>
				<div style="position: absolute; top: 170px; left: 40px;" id="error_legal"><?php echo "<span class='error' >" . $_SESSION['Error_Legal'] . "</span>"; ?></div>
				
				
			</div>
			
		
			<!--Left Side -->
			<div style="position: absolute; top: -20px; left: -60px; z-index: 110" align="left" >
				
				<div style="position: absolute; top: -30px; left: 50px; z-index: 110" >					
					<img src="signup/images/WarIncLogo3.png" border="0" width="500" >					
				</div>
				
				
					
				
				
				<div style="position: absolute; top: 320px; left: 150px; width: 260; z-index: 150" align="center" >	
					<a href="Javascript: ShowVideo('pQDsThft7FU');" >
						<img src="signup/images/TrailerButton1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GO2','','signup/images/TrailerButton2.png',1)" id="GO2" name="GO2" >
					</a>
				</div>
			
				
				
				<div style="position: absolute; top: 410px; left: 110px; width: 342; z-index: 150" align="center" >	
					<?php
					echo "<a href=\"overview.php?id=" . $InviteCode . "\">";
					?>
						<img src="signup/images/GameOverview1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('GO1','','signup/images/GameOverview2.png',1)" id="GO1" name="GO1" >
					</a>
				</div>
				
					
				<div style="position: absolute; top: 510px; left: 80px; width: 485px; height: 148px; z-index: 150; "	>
				
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
			<div style="position: absolute;  padding: 45px; top: 0px; left: 455px; width: 578px; height: 604px; z-index: 20;" align="left" >
			<!--<div style="position: absolute;  padding: 45px; top: 0px; left: 455px; width: 578px; height: 604px; z-index: 20; background:url('signup/images/PlateBGb.png') no-repeat;" align="left" >-->
		
				<div style="width: 485px; height: 199px; z-index: 20; background:url('signup/images/RegisterBG.png') no-repeat;"	>

				<form id="registerForm" name="registerForm" method="post" action="register-exec.php">
							
					<table style="margin-left: 170px; padding-top: 10px;" >
					  <tr>
					    <td>
							<input name="username" type="text" class="textfield" id="username" value="<?php echo $_SESSION['username']; ?>"  />										  
					    </td>
					  </tr>
					  <tr>
						<td>
							<input name="password" type="password" class="textfield" id="password" value="<?php echo $_SESSION['password']; ?>"  />										 
						</td>
					  </tr>
					  <tr>
						<td>
							<input name="cpassword" type="password" class="textfield" id="cpassword" value="<?php echo $_SESSION['cpassword']; ?>"  />										 
						</td>
					  </tr>
					  <tr>
						<td>
							<input name="email" type="text" class="textfield" id="email" value="<?php echo $_SESSION['email']; ?>"  />										 
						</td>
					  </tr>
					  <tr>
						<!--<td>
							<input name="invitecode" type="text" class="textfield" id="invitecode" value=""  />										 
						</td>-->
					  </tr>
					</table>

					<br><br><br>
					
					<input type="checkbox" name="legal" value="legal" <?php if ($_SESSION['legal'] != '') { echo "CHECKED"; } ?>/> 
					<span class="text_legal" style="color: #FFFFFF !important;" >By Checking the box, you confirm that:<br>
					You agree to the <a href="http://www.thewarinc.com/terms.html" target="_blank" class="legalLink" >Terms of Service</a> and <a href="http://www.thewarinc.com/privacy.html" target="_blank" class="legalLink" >Privacy Policy</a>.	 <br>
					
					</span>

					<input name="inviteKey" type="hidden" value="<?php echo $InviteCode; ?>">

					</form> 
				
				</div>
				
				<br><br><br>
				
				<a href="javaScript:registerAccount()" >
<img src="signup/images/Download1.png" style="margin-left: 25px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Register1','','signup/images/Download2.png',1)" id="Register1" name="Register1" ></a><br>
				
				<br>
				
				<div style="width: 100%; margin-left: -20px;" align="center" >
					<img src="signup/images/SteamWarning3.png" border="0" width="450" >
				</div>
				
				<table width="100%" >
				  <tr>
					<td width="20" >
					</td>
				    <td width="120" >						
						<a href="http://pc.gamespy.com/pc/war-inc/" ><img src="signup/images/Logo_GameSpy2.png" border="0" width="50" ></a>						
					</td>
					<td align="left" valign="top" align="left">						
						<div style="width: 250px;" >
							<br><br>
							"War Inc. is the sort of shooter that might save you the $50 you would have spent on Call of Duty." -GameSpy	
						</div>
					</td>
				  </tr>
				</table>
				<table width="100%" >
				  <tr>
					<td width="20" >
					</td>
				    <td width="120" >						
						<a href="http://www.gamespot.com/features/war-inc-battle-zone-exclusive-trailer-and-launch-rundown-6372155/" ><img src="signup/images/gamespot.png" border="0" width="50" ></a>						
					</td>
					<td align="left" valign="top" align="left">						
						<div style="width: 250px;" >
							<br><br>
							"...going into its launch well-armed."  -GameSpot	
						</div>
					</td>
				  </tr>
				</table>
			</div>
		
			
			
			
			<!--Bottom-->
			<!--<div align="center" style="position: absolute; top: 600px; left: 0px; height: 206px; width: 1023px; ) no-repeat;" >-->
			<div align="center" style="position: absolute; top: 670px; left: 0px; height: 206px; width: 1023px; padding:0px 0px 0px 0px; background: url('signup/images/ScreenshotsBG.png') no-repeat;" >
			
				<!--Screenshots-->
				<div style="margin-left: 100px;" >
				
				<br><br><br>
				
				<div id="gallery">
				
				<!--
				<div style="float: left; margin-top: -8px; width: 80px; visibility: hidden;" >
				<a href="#" ><img src="signup/images/ArrowL1.png" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('AL1','','signup/images/ArrowL2.png',1)" id="AL1" name="AL1" ></a>
				</div>
				-->
				
				<?php
				
					include('screenshots.php');
				
					for ($i=0;$i<5;$i++) {
					
						echo "
							<div style=\"position: relative; float: left; width: 170px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media/Screenshots/$myScreenShots[$i]\" rel=\"lightbox[media]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media/Screenshots/$myScreenShots_resize[$i]\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
					
					}
					
					
				
				
				?>
				
					<!--
					<div style="float: left; margin-top: -8px; margin-left: -20px; visibility: hidden;" >
					<a href="#" ><img src="signup/images/ArrowR1.png"  border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('AR1','','signup/images/ArrowR2.png',1)" id="AR1" name="AR1" ></a>
					</div>					
					-->
					
					<div style="clear: both;" ></div>
				
				</div>
				
					
					
				</div>
			
				<br>
				
				<!--Footer-->
				<div align="center" style="z-index: 100; " >				
					
					<img src="signup/images/hl.png" border="0" > <br>
					
					<table width="800px" align="center" style="margin-top: 5px;" >
					  <tr>
					    <td>
						
							<img src="signup/images/WarmongersLogo2.png" border="0" ><br>

						</td>
						<td>
						
						<img src="signup/images/GamingEvolved.png" border="0" height="80" >
						
						</td>
						<td style="color: #66ccff;" >
						
							<a href="http://support.thewarinc.com/">Support</a> | 
							<a href="http://www.thewarinc.com/privacy.html">Privacy Policy</a> |
							<a href="http://www.thewarinc.com/terms.html">Terms of Use</a>	
						
						</td>
						<td class="text_footer" >
										
							&copy; Online Warmongers Group, inc. All rights reserved.<br>
						
							
							
						
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

<?php
	// unset all stored vars, so page reload won't show them again
	unset($_SESSION['username']);
	unset($_SESSION['password']);
	unset($_SESSION['cpassword']);
	unset($_SESSION['email']);
	unset($_SESSION['legal']);
	unset($_SESSION['Error_Username']);
	unset($_SESSION['Error_Password']);
	unset($_SESSION['Error_Email']);
	unset($_SESSION['Error_Legal']);
?>