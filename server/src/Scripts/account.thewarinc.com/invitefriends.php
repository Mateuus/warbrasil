<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php');
	require_once('invitekey.inc.php');
	
	$CustomerID = $_SESSION['CustomerID'];
	$InviteKey  = invitekey_encode($CustomerID);
	$MyReferralLink = "http://signup.thewarinc.com/?id=" . $InviteKey;
	
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
			<div class="bg_invite_friends">
				<div class="name02_1"><img src="images/02_name_1.gif"  alt="" border="0px" /></div>
				<p class="text_1">Do you have friends who want to join you in War Inc. Battlezone? From now on you can earn rewards for every friend you invite!</p>
				<div class="line_3"></div>
				<div class="personal_link_repeat">
					<div class="personal_link_top">
						<div class="personal_link_bottom">
							<div><img src="images/02_name_2.gif"  alt="" border="0px" /></div>
							<div class="form"><input  type="text"  name="q" value="<?php echo $MyReferralLink; ?>" class="form1" /></div>
						</div>
					</div>
				</div>
				<div class="img_11">10</div>
				<p class="text_2">Share the <span>referral link</span> with<br/> your friends.</p>
				<p class="text_2">Your friend must play and get to<br/><span>Level 10</span>.<br/> Track your friends' progress <a href="invitestatus.php" class="link">here</a></p>
				<p class="text_2">Profit!<br/>As you refer more friends, you get more and <span>bigger rewards</span>!</p>
				<div class="cL"></div>	
			</div>
		</div>
		<!--<div class="shadow10_bottom"><div class="bottom_5"></div></div>-->
		<div class="shadow4_bottom"></div>
		
		
		<div class="shadow5_top"></div>	
		<div class="shadow5_repeat">
			<div class="head_table">
				<div class="tr1_td1">referrals</div>
				<div class="tr1_td2">rewards</div>
				<div class="cL"></div>	
			</div>
			<div class="body_table">
			
				<div class="table_repeat1">
					<div class="table_top1">
						<div class="table_bottom1">
							<div class="tr2_td1">1</div>
							<div class="tr2_td2">500 GC</div>							
							<div class="tr2_td1">5</div>
							<div class="tr2_td2">30 day rental of any weapon</div>							
							<div class="tr2_td1">10</div>
							<div class="tr2_td2">5,000 Gold Credits ( approx. $5 value )</div>							
							<div class="tr2_td1">25</div>
							<div class="tr2_td2">Special "Recruiter" title on forums</div>							
							<div class="tr2_td1">50</div>
							<div class="tr2_td2">Collectors Pack ( $34.99 value )</div>							
							<div class="tr2_td1">100</div>
							<div class="tr2_td2">50,000 Gold Credits ( approx. $40 value )</div>						
							<div class="tr2_td1">1,000</div>
							<div class="tr2_td2">Permanent unlock of all items in the store ( approx. $1,000 value )</div>
							<div class="cL"></div>	
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<div class="shadow5_bottom"></div>
		
		
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
