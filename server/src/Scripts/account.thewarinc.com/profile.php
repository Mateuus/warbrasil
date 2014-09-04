<?php
	
	session_start();
	require_once('auth.php'); 
	require_once('dbinfo.inc.php');

	$CustomerID = $_SESSION['CustomerID'];

	// create & execute query
	$tsql   = "SELECT * FROM AccountInfo WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);
						
	$CustomerID=trim($member['CustomerID']);
	$email=trim($member['email']);
	$firstname=trim($member['firstname']);
	$lastname=trim($member['lastname']);
	$sex=trim($member['sex']);
	$dob = date_format($member['dob'], "M j Y");
	$street=trim($member['street']);
	$city=trim($member['city']);
	$state=trim($member['state']);
	$zip=trim($member['postalcode']);
	$country=trim($member['Country']);
	$phone=trim($member['phone']);

	// create & execute query
	$tsql   = "SELECT * FROM LoginID WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);
						
	$username=$member['AccountName'];
	$gamertag=$member['Gamertag'];
	$accstatus=$member['AccountStatus'];
	$gamepoints=$member['GamePoints'];
	$HonorPoints=$member['HonorPoints'];
	$SkillPoints=$member['SkillPoints'];
	$dateregistered=date_format($member['dateregistered'], "M j Y");
	$lastlogindate=date_format($member['lastlogindate'], "M j Y");
	$lastloginIP=$member['lastloginIP'];
	$lastgamedate=date_format($member['lastgamedate'], "M j Y");
	
	$FacebookLink = "";
	$TwitterLink = "";

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Profile</title>
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

	<div id="header">
		<div class="header">
			<a href="index.php"   class="logo"></a>
			<div class="block_id" align="right">
				<a href="profile.php"   class="name"><?php echo $_SESSION['AccountName']; ?></a>
				<a href="logout-exec.php"   class="logout"></a>
			</div>
			<div class="cL"></div>
			<div class="line_header"></div>
			<ul class="navigation">
				<li class="menu_1"><a href="home.php"></a></li>
				<li class="menu_2 active_2"><a href="profile.php"></a></li>
				<li class="menu_3"><a href="invitefriends.php"></a></li>
				<li class="menu_4"><a href="key.php"></a></li>
				<li class="menu_5"><a href="store.php"></a></li>
				<li class="menu_6"><a href="earn.php"></a></li>
				<li class="menu_7"><a href="history.php"></a></li>
			</ul>
			<div class="cL"></div>
		</div>
	</div>
	
<!-- HEADER EOF   -->	

<!-- BEGIN CONTENT -->

	<div id="content">
		<div class="shadow7_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
				<div class="fL_names1">
					<div class="block">
						<div align="right" class="img"><img src="images/first_name.gif" alt="" border="0px" /></div>
						<p><?php echo $firstname; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/last_name.gif" alt="" border="0px" /></div>
						<p><?php echo $lastname; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/gamertag.gif" alt="" border="0px" /></div>
						<p><?php echo $gamertag; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/e-mail_address.gif" alt="" border="0px" /></div>
						<p><a href="#"><?php echo $email; ?></a></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/sex.gif" alt="" border="0px" /></div>
						<p><?php
							if ($sex == "0")
							{		
								echo "Male";
							} else
							{
								echo "Female";
							}
							?>
						</p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/date_of_birth.gif" alt="" border="0px" /></div>
						<p><?php echo $dob; ?></p>
						<div class="cL"></div>	
					</div>
				</div>
				<div class="fL_names2">
					<div class="block">
						<div align="right" class="img"><img src="images/street.gif" alt="" border="0px" /></div>
						<p><?php echo $street; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/city.gif" alt="" border="0px" /></div>
						<p><?php echo $city; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/state.gif" alt="" border="0px" /></div>
						<p><?php echo $state; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/zip.gif" alt="" border="0px" /></div>
						<p><?php echo $zip; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/country.gif" alt="" border="0px" /></div>
						<p><?php echo $country; ?></p>
						<div class="cL"></div>	
					</div>
					<div class="block">
						<div align="right" class="img"><img src="images/phone.gif" alt="" border="0px" /></div>
						<p><?php echo $phone; ?></p>
						<div class="cL"></div>	
					</div>
				</div>
				<div class="cL"></div>
				<div class="line_5"></div>	
				<div class="fL_date_registered">
					<div align="right"><img src="images/date_registered.gif" alt="" border="0px" /></div>
					<p><?php echo $dateregistered; ?></p>
				</div>
				<div class="fL_date_registered2">
					<div align="right"><img src="images/last_login_date.gif" alt="" border="0px" /></div>
					<p><?php echo $lastlogindate; ?></p>
				</div>
				<div class="fL_date_registered3">
					<div align="right"><img src="images/last_login_ip.gif" alt="" border="0px" /></div>
					<p><?php echo $lastloginIP; ?></p>
				</div>
				<div class="cL"></div>
				<br>
				<!--<div class="line_6"></div>	
				<div class="facebook"><a href="#"><?php //echo $FacebookLink; ?></a></div>
				<div class="twitter"><a href="#"><?php //echo $TwitterLink; ?></a></div>-->
				<a href="password.php" class="change_password_off"></a>
				<a href="profile-edit.php" class="edit_profile_off"></a>
				<div class="cL"></div>	
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_4"></div></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
