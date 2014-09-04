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
	
	<link href="css/style.css" rel="stylesheet" type="text/css" />
	
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	
	<script src="js/rollovers.js" type="text/javascript"></script>
	<script src="js/highlight.js" type="text/javascript"></script>
	
	<script src="js/jquery-1.4.3.min.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="js/jquery.lightbox-0.5.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.lightbox-0.5.css" media="screen" />
	

	<script type="text/javascript" src="js/jcarousel/lib/jquery.jcarousel.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/jcarousel/skins/tango/skin.css" />
	
	<!--<script type="text/javascript" src="js/overview.js"></script>-->
	<link href="css/overview.css" rel="stylesheet" type="text/css" />
	
	
</head>	

<body>

<!--Video Pop Up-->	
<div id="VideoPopUp" align="center" style="display: none; position: absolute; top: 260px; left: 0px; z-index: 900; width: 100%;" >
	
	<div style="width: 670px; height: 430px; padding: 0px;z-index: 900; background-color: #FFFFFF; border: 1px solid #000;" >
	
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




<!--Outer Div-->
<div style="position: relative; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 100;" align="center" >


					
	<!--Container Div-->
	<div style="width: 1024px; z-index: 100;" align="left" >
	
		<!--Header-->
		<br>
		<div align="left" style="width: 100%;" >
			
			<table width="100%" >
			  <tr>
				<td>
				<img src="images/WarIncLogo.png" border="0"  >
				</td>
				<td>
				<a href="http://signup.thewarinc.com" ><img src="images/Play1.png" style="margin-left: 0px;" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Register1','','images/Play2.png',1)" id="Register1" name="Register1" ></a>
				</td>
			  </tr>
			</table>
								
		</div>
		<br>

		<!--Content-->
		<div style="position: relative; top: 0px; left: 0px; width: 100%; z-index: 100" align="center" >
		
			<!--Table Top-->
			<div style="position: relative; top: 0px; left: 0px; width: 788px; height: 422px; background:url('images/MenuBG_Top2.png') no-repeat; z-index: 2;" >
				
					
				
			</div>
			<!--Table Mid-->
			<div style="position: relative; top: 0px; left: 0px; width: 800px; background:url('images/MenuBG_Mid2.png') repeat-y; z-index: 2;" >
				
				
			</div>
			<!--Table Bot-->
			<div style="position: relative; top: 0px; left: 0px; width: 800px; height: 93px;  background:url('images/MenuBG_Bot2.png') no-repeat; z-index: 2;" >
				
				
			</div>
		

			<!--Bottom-->
			<div style="position: relative; top: 10px; left: 0px" >
			
				
			</div>
			

		</div>			

	</div>	

</div>








</body>
</html>
