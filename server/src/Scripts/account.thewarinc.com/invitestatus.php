<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php');
	require_once('invitekey.inc.php');
	
	$CustomerID = $_SESSION['CustomerID'];
	$InviteKey  = invitekey_encode($CustomerID);
	$MyReferralLink = "http://signup.thewarinc.com/?id=" . $InviteKey;
	
?>
<?php
	require_once('dbinfo.inc.php');

	$NumbersInvited = 0;

	$InviteStatus_Username = array();	
	$InviteStatus_Rank = array();
	$InviteStatus_LTP = array();
	$InviteStatus_Email = array();
	
/*
	//FAKE DATA	
	$InviteStatus_Username[0] = "brian";
	$InviteStatus_Rank[0] = "60";
	$InviteStatus_LTP[0] = "Dec 21, 2012 23:59";
	$InviteStatus_Email[0] = "bclarke@thewarinc.com";
*/

	//GET INVITE STATUS
	$tsql   = "EXEC ECLIPSE_UserInviteGetStatus2 ?";
	$params = array($CustomerID);
	$stmt   = sqlsrv_query($conn, $tsql, $params);

	$i = 0;
	while($member = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC))
	{
		// username
		$InviteStatus_Username[$i] = $member['Gamertag'];

		// rank
		$rank = $member['Rank'];
		$InviteStatus_Rank[$i] = $rank;
		if($rank >= 10) {
			$NumbersInvited++;
		}

		// last time played
		$ltp = $member['lastgamedate'];
		$InviteStatus_LTP[$i] = date_format($ltp, "M d, Y H:i");
		if($InviteStatus_LTP[$i] == "Jan 01, 1973 12:00")
			$InviteStatus_LTP[$i] = "NEVER";

		// email
		$InviteStatus_Email[$i] = $member['email'];

		$i++;
	}


?>
<?php

	function show_invitestatus_row($hUsername,$hRank, $hLTP,$hEmail,$hBG) {
	
		if ($hBG == "1") {
			$hBGClass = "tr_1";
		}
		else {
			$hBGClass = "tr_2";
		}

		echo "
			<div class=\"$hBGClass\">
				<div class=\"td1_1\">$hUsername</div>
				<div class=\"td1_2\">$hRank</div>				
				<div class=\"td1_3\">$hLTP</div>
				<div class=\"td1_4\">$hEmail</div>
				<div class=\"cL\"></div>
			</div>
			";	
	}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Invite Friends</title>
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
				<li class="menu_2"><a href="profile.php"></a></li>
				<li class="menu_3 active_3"><a href="invitefriends.php"></a></li>
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
				<div class="name02_1"><img src="images/02_name_1.gif"  alt="" border="0px" /></div>
				<p class="text_1">You have invited <?php echo $NumbersInvited; ?> friends that have achieved Rank 10.</p>
				<div class="line_3"></div>
				<div class="personal_link_repeat">
					<div class="personal_link_top">
						<div class="personal_link_bottom">
							<div><img src="images/02_name_2.gif"  alt="" border="0px" /></div>
							<div class="form"><input  type="text"  name="q" value="<?php echo $MyReferralLink; ?>" class="form1" /></div>
						</div>
					</div>
				</div>
				<div class="cL"></div>
				<div class="block1_table1">Username</div>	
				<div class="block1_table2">Rank</div>				
				<div class="block1_table3">Last Time Played</div>	
				<div class="block1_table4">Email</div>	
				<div class="cL"></div>
				<div class="bg_table">
					<div style="width: 100%; height: 400px; overlow: auto;" >
						
						<?php						
							
							$bgToggle = "2";
							
							for($i=0;$i<sizeof($InviteStatus_Username);$i++) {
							
								if ($bgToggle == "1") {
									$bgToggle = "2";
								}
								else {
									$bgToggle = "1";
								}			
							
								show_invitestatus_row($InviteStatus_Username[$i],$InviteStatus_Rank[$i],$InviteStatus_LTP[$i],$InviteStatus_Email[$i],$bgToggle);
							
							}	
							
	
						
						?>
					
									
					</div>
				</div>
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_5"></div></div>

	
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
