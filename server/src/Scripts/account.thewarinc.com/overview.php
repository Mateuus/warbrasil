<?php

	$InviteCode = $_GET['id'];

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
    <link rel="stylesheet" type="text/css" href="signup/css/jquery.lightbox-0.5.css" signup/Media/="screen" />
	

	<script type="text/javascript" src="signup/js/jcarousel/lib/jquery.jcarousel.min.js"></script>
	<link rel="stylesheet" type="text/css" href="signup/js/jcarousel/skins/tango/skin.css" />
	
	<script type="text/javascript" src="signup/js/overview.js"></script>
	<link href="signup/css/overview.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="signup/js/swfobject.js"></script> 
	
	
</head>	

<body>

<!--Video Pop Up-->	
<div id="VideoPopUp" align="center" style="display: none; position: absolute; top: 260px; left: 0px; z-index: 900; width: 100%;" >
	
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




<!--Outer Div-->
<div style="position: relative; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100;" align="center" >

					
	<!--Container Div-->
	<div style="width: 1024px; z-index: 100;" align="left" >
	
		<!--Header-->
		<br>
		<div align="center" style="width: 100%;" >
			
			<table width="778" align="center" >
			  <tr>
				<td align="left" width="450" >
				<a href="" ><img src="signup/images/WarIncLogo.png" border="0"  ></a>
				</td>
				<td align="center" >

				
				<div id="flashbutton1">
					<?php
					echo "<a href=\"register.php?id=$InviteCode\">";
					?>
						<img src="signup/images/bullet_button_off.png" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Register1','','signup/images/bullet_button_on.png',1)" id="Register1" name="Register1" >
					</a>
				</div>
				
				<script type="text/javascript">
				   /*
				   var so = new SWFObject("signup/images/bullet_button.swf", "fl_button1", "533", "115", "6", "#000000");
					so.addParam("wmode", "transparent");
					so.addVariable("InviteCode", "<?php echo $InviteCode; ?>");
				    so.write("flashbutton1"); 
					*/
				</script> 

				</td>
			  </tr>
			</table>
								
		</div>
		<br>

		<!--Content-->
		<div style="position: relative; top: 0px; left: 0px; width: 100%; z-index: 100" align="center" >
		
			<!--Table Top-->
			<div style="position: relative; top: 0px; left: 0px; width: 778px; height: 463px; background:url('signup/images/MenuBG_Top2b.png') no-repeat; z-index: 2;" >
				
				
				<br><br>
				
				<div style="margin-left: 40px;" >
				
				
				<table width="100%" cellpadding="2" cellspacing="0"  >
				  <tr>
					<td width="280" valign="top" align="left" >
					
						<span class="text_whiteBig" ><a href="register.php?id=<?php echo $InviteCode; ?>" >Join Now!</a></span><br>
						<br>
						
						<span class="text_blue" >
						The battle has just begun and it's <span class="text_white" >YOUR</span> opportunity to fight alongside elite Soldiers and Mercenaries.<br>
						Create your class from <span class="text_white" >dozens of possible combinations</span>, from heavy weapon frontline Assault, or a Sniper that rains destruction from afar.<br>
						Over <span class="text_white" >140 different weapons and hundreds of character customization options </span> allow for maximum customization and perfection of <span class="text_white" >YOUR</span> play style.<br>
						<br>
						<span class="text_white" >War Inc. Battlezone</span> delivers hard hitting combat in multiplayer, session-based games of 8v8, and 16v16 in Para-military action themes.<br>
						<br>
						<a href="register.php?id=<?php echo $InviteCode; ?>" >Play the game For Free now!</a><br>
						<br>
						</span>
						

						<a href="Javascript: ShowVideo('pQDsThft7FU');" ><img src="signup/images/TrailerButton1.png" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('TrailerButton','','signup/images/TrailerButton2.png',1)" id="TrailerButton" name="TrailerButton" ></a><br>	


					</td>
					<td valign="top" align="left" >
					
						<div style="padding: 10px; width: 419px; height: 260px; background: url('signup/images/Frame.png') no-repeat;" >
						
							<div id="slideshow-main2" style="margin-left: 0px;" >
							
							<ul>
							
								<?php
								
									include('screenshots.php');
								

									for ($i=0;$i<sizeof($myScreenShots);$i++) {
									
										if ($i == 0) {
										 $myClass = "ss" . $i . " active";
										}
										else {
									
											$myClass = "ss" . $i;
										}
									
										echo "
											<li class=\"$myClass\" ><img src=\"signup/Media/Screenshots/$myScreenShots[$i]\" width=\"400\" height=\"240\" /></li>
											
											";
									
									}
									
									
								
								?>
							
	
							</ul>
						</div>
						
							
						</div>
						
						
				
						 <div id="slideshow-carousel2">		
							<ul id="carousel2" class="jcarousel jcarousel-skin-tango">
						 
							<?php
								
			
								for ($i=0;$i<sizeof($myScreenShots);$i++) {
								
									
									$myClass = "ss" . $i;
								
									echo "
										<li><a href=\"#\" rel=\"$myClass\"><img src=\"signup/Media//Screenshots/$myScreenShots[$i]\" alt=\"\" title=\"\" width=\"60\" height=\"38\" /></a></li>
										
										";
								
								}
								
								
							
							?>
						 

						 
							</ul>
						</div>

					

			
					
					</td>
				  </tr>
				</table>
					
				</div>
				
				<br><br>
				
				<img src="signup/images/hl.png" border="0" > <br>	
				
				
				
			</div>
			<!--Table Mid-->
			<div style="position: relative; top: 0px; left: 0px; width: 778px; background:url('signup/images/MenuBG_Mid2b.png') repeat-y; z-index: 2;" >
				
				<div style="margin-left: 40px; padding-top: 50px;" >
				
				<!--Features1-->
				<table width="100%" cellpadding="0" cellspacing="0" >
				  <tr>
					<td width="310" valign="top" align="left" >
					
					<table><tr><td><img src="signup/images/bullet.png" border="0" ></td><td class="text_Features" >FEATURES</td></tr></table><br>
					
					
					
					<div id="F1"><a href="#" rel="p1" ><img src="signup/images/Feature1_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature1','','signup/images/Feature1_2.png',1)" id="Feature1" name="Feature1" ></a></div>	
					<div id="F2"><a href="#" rel="p2" ><img src="signup/images/Feature2_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature2','','signup/images/Feature2_2.png',1)" id="Feature2" name="Feature2" ></a></div>	
					<div id="F3"><a href="#" rel="p3" ><img src="signup/images/Feature3_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature3','','signup/images/Feature3_2.png',1)" id="Feature3" name="Feature3" ></a></div>	
					<div id="F4"><a href="#" rel="p4" ><img src="signup/images/Feature4_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature4','','signup/images/Feature4_2.png',1)" id="Feature4" name="Feature4" ></a></div>		
					<div id="F5"><a href="#" rel="p5" ><img src="signup/images/Feature5_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature5','','signup/images/Feature5_2.png',1)" id="Feature5" name="Feature5" ></a></div>		
					<div id="F6"><a href="#" rel="p6" ><img src="signup/images/Feature6_1.png" width="256" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Feature6','','signup/images/Feature6_2.png',1)" id="Feature6" name="Feature6" ></a></div>		
	
					
					
					
					</td>
					<td valign="top" >
					
						<div style="background: url('signup/images/FeaturesRightBG.png') no-repeat; width: 371px; height: 190px; margin-top: 50px;" >
					
							<div id="slideshow-main">
							
							<ul>
								<li class="p1 active">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >

											<img src="signup/images/Feature6.png"  alt=""/>
											
											<br>
											<span class="text_blue">
											Cutting edge Graphics from the leaders in session based<br>
											gaming and online multiplayer, War Inc. Battlezone features a <span class="text_white">unique Third Person view</span> with <span class="text_white">Smart Camera</span><br>
											functionality, Finely Tuned.
											</span>
										
										</div>	
									
									
								</li>
								<li class="p2">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >

											<img src="signup/images/Feature5.png" alt=""/>
										
											<br>
											<span class="text_blue">
											Create up to <span class="text_white">6 different Characters</span> from the<br>
											<span class="text_white">8 available skill trees</span>, War Inc offers exceptional<br>
											versatility and freedom to design your perfect class.<br>
											Each level gained earns <span class="text_white">Skill Points</span> which can be assigned to<br>
											improve Armor, Fire Rates, Reloading and more.
											</span>
											
										</div>
										
										
										
								</li>
								<li class="p3">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >
											
											<img src="signup/images/Feature4.png"  alt=""/>
										
											<br>
											<span class="text_blue">
											Special Account features allow players to <span class="text_white">create and host<br>
											their own games</span>. War Inc is the <span class="text_white">ONLY</span> free to play shooter<br>
											that <span class="text_white">allows Players to Browse and Select which match they<br>
											want to join</span>. An extensive <span class="text_white">Chat Suite</span> allows in game commu-<br>
											nication globally to your team or other players.
											</span>
										
										</div>
										
																			
										
								</li>
								<li class="p4">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >

											<img src="signup/images/Feature3.png" alt=""/>
										
											<br>
											<span class="text_blue">
											War Inc: Battlezone features <span class="text_white">Constant monitoring</span> by Admins<br>
											and its Creators to ensure a fair and balanced system that<br>
											ruthlessly prohibits and responds to Cheaters.<br>
											Your Game will <span class="text_white">NOT</span> be ruined by cheats!
											</span>
										
										</div>	
										
								</li>
								<li class="p5">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >
											
											<img src="signup/images/Feature2.png"  alt=""/>
										
											<br>
											<span class="text_blue">
											The <span class="text_white">AAA</span> development team is constantly adding new<br>
											features, while also polishing and balancing the<br>
											gameplay.<br>
											<span class="text_white">War Inc</span> has something new <span class="text_white">every week</span> to keep the game-<br>
											play fresh and Players coming back for more.<br>
											</span>
										
										</div>
										
								</li>
								<li class="p6">
									
										<div align="left" style="padding: 10px; padding-left: 15px;" >
											<img src="signup/images/Feature1.png"  alt=""/>
										
											
											<br>
											<span class="text_blue">
											War Inc is <span class="text_white">free to play</span>, and <span class="text_white">free to download</span>.<br>
											The game is balanced to ensure that <span class="text_white">Competitive Players</span> are<br>
											rewarded, in addition to <span class="text_white">Loyal Players</span>.<br>
											<span class="text_white">No credit card is needed</span> to enjoy the best combat action!
											</span>
										</div>
										
										
										
								</li>
							</ul>
							
							

							<div id="ScrollButtons" class="jcarousel-skin-tango" style="position: relative; top: -130px; left: 140px; width: 100px;" >
								<div style="position: absolute; top: 0px; left: -30px;" ><div id="LeftButton" class="jcarousel-prev-horizontal"></div></div>
						
								<div style="position: absolute; top: 0px; left: 135px;" ><div id="RightButton" class="jcarousel-next-horizontal" ></div></div>
							</div>
															
						</div>
						
						</div>

						<div id="slideshow-carousel" style="display: none !important;" >		
							<ul id="carousel" class="jcarousel jcarousel-skin-tango">
							 
								<li>
									<a href="#" rel="p1"><img src="signup/images/Feature1.png" alt="" title="" width="100" height="100" /></a>
								</li>
								<li>
									<a href="#" rel="p2"><img src="signup/images/Feature2.png" alt="" title="" width="100" height="100" /></a>
								</li>
								<li>
									<a href="#" rel="p3"><img src="signup/images/Feature3.png" alt="" title="" width="100" height="100" /></a>
								</li>
								<li>
									<a href="#" rel="p4"><img src="signup/images/Feature4.png" alt="" title="" width="100" height="100" /></a>
								</li>
								<li>
									<a href="#" rel="p5"><img src="signup/images/Feature5.png" alt="" title="" width="100" height="100" /></a>
								</li>
								<li>
									<a href="#" rel="p6"><img src="signup/images/Feature6.png" alt="" title="" width="100" height="100" /></a>
								</li>
							
							 
							</ul>
						</div>

					

			
					
					</td>
				  </tr>
				</table>
				
				</div>
				
				<img src="signup/images/hl.png" border="0" > <br>
				<br>
				<br>
				
				<!--Features2-->
				<div align="left" style="margin-left: 40px;" >
				
					<span class="text_yellow" >130+ WEAPONS</span><br>
					<br>
					<span class="text_blue" >Select from <span class="text_white" >over 140 weapons</span> available in game, with more being added every month.
					Each weapon has its specific set of Statistics; <span class="text_white" >Damage, Fire Rate, Accuracy</span> and <span class="text_white" >Capacity</span><br>
					</span><br>
				
					<div id="gallery1" style="padding-top: 18px; padding-left: 40px; width: 701px; height: 121px; background: url('signup/images/SSBG.png') no-repeat;" >
				<?php
				
					//include('screenshots.php');
					
					$i = "W1";
					
					echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Weapons/Weap_Wall_Render_01.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Weapons/Weap_Wall_Render_01_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = "W2";
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Weapons/Weap_Wall_Render_02.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Weapons/Weap_Wall_Render_02_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = "W3";
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Weapons/Weap_Wall_Render_03.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Weapons/Weap_Wall_Render_03_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = "W4";
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Weapons/Weap_Wall_Render_04.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Weapons/Weap_Wall_Render_04_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
				
				
					
					echo "<div style=\"clear: both;\" ></div>";
				
				
				?>
				</div>
				
					
					<img src="signup/images/hl.png" border="0" style="margin-left: -40px;" > <br>
					<br>
				
					<span class="text_yellow" >MAPS AND GAME MODES</span><br>
					<br>
					<span class="text_blue" >Multiple <span class="text_white" >Maps</span> and <span class="text_white" >Game Modes</span>.<br>
					Desert Village Squad Firefights, Urban Chaos or Close Quarter Shipyard, with <span class="text_white" >Conquest</span> and <span class="text_white" >Deathmatch</span> modes available.<br>
					Click on a Map Below to learn More<br>
					</span><br>
				
					<div id="gallery2" style="padding-top: 18px; padding-left: 40px; width: 701px; height: 121px; background: url('signup/images/SSBG.png') no-repeat;" >
				<?php
				
					//include('screenshots.php');
				
					//for ($i=5;$i<9;$i++) {
					
						$i = 5;
					
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Screenshots/BurningSea.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Screenshots/BurningSea_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = 6; 
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Screenshots/Crossroads.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Screenshots/Crossroads_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = 7;
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Screenshots/JungleRuins.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Screenshots/JungleRuins_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
						
						$i = 8;
						
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Screenshots/Nightfall.jpg\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Screenshots/Nightfall_resize.jpg\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
					
				//	}
					
					echo "<div style=\"clear: both;\" ></div>";
				
				
				?>
				</div>
				
					
					<img src="signup/images/hl.png" border="0" style="margin-left: -40px;" > <br>
					<br>
				
					<span class="text_yellow" >PERSISTENT CHARACTER</span><br>
					<br>
					<span class="text_blue" >Customize your Character with up to <span class="text_white" >6 different Load-Out slots</span>, <span class="text_white" >Special Gear</span>, <span class="text_white" >Armor</span>, <span class="text_white" >Items</span>, and <span class="text_white" >Perks</span>.<br>
					The possibilities are endless with so many different items and combinations.<br>
					</span><br>
				
					<div id="gallery3" style="padding-top: 18px; padding-left: 40px; width: 701px; height: 121px; background: url('signup/images/SSBG.png') no-repeat;" >
				<?php
				
					//include('screenshots.php');
				
					for ($i=10;$i<14;$i++) {
					
						echo "
							<div style=\"position: relative; float: left; width: 160px; height: 90px; z-index: 11;\">
					
								<div style=\"position:absolute; top:1px; left:1px; z-index: 17;\">
								  <a href=\"signup/Media//Screenshots/$myScreenShots[$i]\" rel=\"lightbox[signup/Media/]\" onmouseout=\"unhighlightPic('Border$i')\" onmouseover=\"highlightPic('Border$i')\"><img src=\"signup/images/blank.gif\" width=\"140\" height=\"90\" border=\"0\"  ></a>
								</div>
								
								<div style=\"position:absolute; top:1px; left:1px; z-index: 15;\">
								  <img src=\"signup/images/Frame2.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\" style=\"visibility:hidden;\" name=\"Border$i\" id=\"Border$i\" >
								</div>	

								<div style=\"position:absolute; top:1px; left:1px; z-index: 14;\">
								  <img src=\"signup/images/Frame1.png\" width=\"140\"  border=\"0\" name=\"Border$i\" id=\"Border$i\"  >
								</div>	

								<div style=\"position:absolute; top:0px; left:0px; z-index: 13;\">
								  <img src=\"signup/Media//Screenshots/$myScreenShots_resize[$i]\" width=\"140\" height=\"84\" class=\"myImages\" name=\"Image$i\" id=\"Image$i\" >
								</div>

							</div>		
						";
					
					}
					
					echo "<div style=\"clear: both;\" ></div>";
				
				
				?>
				</div>
		
				</div>
				
			</div>
			<!--Table Bot-->
			<div style="position: relative; top: 0px; left: 0px; width: 778px; height: 74px;  background:url('signup/images/MenuBG_Bot2b.png') no-repeat; z-index: 2;" >
				
				<!--Soldier Left-->
				<div id="SoldierL" style="z-index: -50; position: absolute; top: -460px; left: -165px; z-index: 1; background: url('signup/images/SoldierL.png') no-repeat; width: 221px; height: 457px;" >
					
				</div>
				<div id="SoldierL" style="z-index: -50; position: absolute; top: -3px; left: -151px; z-index: 1; background: url('signup/images/SoldierL2.png') no-repeat; width: 358px; height: 151px;" >
					
				</div>

				<!--Soldier Right-->
				<div id="SoldierR" style="position: absolute; top: -485px; left: 695px; z-index: 1; background: url('signup/images/SoldierR.png') no-repeat; width: 313px; height: 612px;" >
				
				</div>
				
			</div>
			
			<!--Bottom-->
			<div style="position: relative; top: 10px; left: 0px; width: 100%;" align="left" >
			
				<!--Minimin Requirements-->
				<table width="900" align="center" >
				  <tr>
				    <td align="left" >
				
				<div id="flashbutton2">
					<?php
					echo "<a href=\"register.php?id=$InviteCode\">";
					?>
						<img src="signup/images/bullet_button_off.png" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Register2','','signup/images/bullet_button_on.png',1)" id="Register2" name="Register2" >
					</a>
				</div>
				
				
				<script type="text/javascript">
				   /*
				   var so = new SWFObject("signup/images/bullet_button.swf", "fl_button2", "533", "115", "6", "#000000");
					so.addParam("wmode", "transparent");
					so.addVariable("InviteCode", "<?php echo $InviteCode; ?>");
				    so.write("flashbutton2"); 
					*/
				</script> 
				
					</td>
					<td align="left" >
					
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
							&nbsp;&nbsp;nVidia 9600 or similar ATI<br>
							&nbsp;&nbsp;512MB dedicated video memory<br>
							&nbsp;&nbsp;Pixel shaders 3.0<br>
							</td>
						  </tr>						  
						</table>
						
						

					</td> 
				  </tr>
				</table>
				

			</div>
			
			<br><br><br>
			
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






</body>
</html>
