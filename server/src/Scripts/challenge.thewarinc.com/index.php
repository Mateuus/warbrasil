<?php
	date_default_timezone_set("America/Los_Angeles");

	$IsActive  = 0;
	$StartDate = null;
	$EndDate   = null;
	$Target    = 0;
	$Current   = 0;

	require_once('dbinfo.inc.php');
	update_challenge();

	if($IsActive == 0) {
		header("location: notactive.php");
		exit();
	}


	// recalc current left time & progress
	$perc  = get_progress();

	$diff  = $EndDate->format("U") - time();
	$days  = (int)($diff / (60 * 60 * 24));
	$diff  -= $days * (60 * 60 * 24);
	$hours = (int)($diff / (60 * 60));
	$diff  -= $hours * (60 * 60);
	$mins  = (int)($diff / 60);

function update_challenge()
{
	global $IsActive;
	global $StartDate;
	global $EndDate;
	global $Target;
	global $Current;

	global $conn;

	// create & execute query
	$tsql   = "EXEC WO_ChallengeGetStatus";
	$params = array();
	$member = db_exec($conn, $tsql, $params);

	$IsActive  = $member["IsActive"];
	$StartDate = $member["StartDate"];
	$EndDate   = $member["EndDate"];
	$Target    = $member["Target"];
	$Current   = $member["Current"];
}

function get_progress()
{
	global $Target;
	global $Current;

	if($Target == 0)
		return (int)0;

	$perc = $Current / $Target * 100.0;
	if(perc > 100) $perc = 100;
	return (int)$perc;
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen, projection" />
    <script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
</head>

<body>

<div id="wrapper">
	<div id="content">
		<div class="top_banner"><img src="pic/banner.jpg" height="505" width="1024" alt="" title="" /></div>
		<div class="text_block">

Great news! The Team at Online Warmongers has decided to give you some new fun in the form of Community Challenges! Community Challenges will be exactly that, challenges to the entire community of War Inc. Battlezone. When you participate in the game during a community challenge period you will be contributing to reaching a goal for the entire player community. When that goal is met, you and all other players in the community who have played during that period will receive a special prizes or bonus from the Online Warmongers Team. We will be hosting these community challenges on a regular basis, so watch for future notifications of up-coming challenges!<br>
<br>
The FIRST Community Challenge will begin on 10/14/2011 and will run through 10/16/2011.<br>
<br> 
This Community Challenge will be to capture a total of 80,000 flags. The entire community of players will contribute to reaching this number by participating in conquest games and capturing those flags! (And yeah, we know you can do it!)<br>
<br> 
For your heroic combat efforts during this challenge period you will receive a reward of 10,000 GP! Yes, this is for everyone who participates during the play period if the goal of 80,000 captured flags is reached! (The terms are subject to change).  <br>
<br> 
So grab your friends and jump into War Inc. Battlezone this weekend and help to reach that community challenge goal!<br>
		</div>
        <div class="time_left">
        	<ul>
            	<li class="days">0</li>
                <li class="hours">0</li>
                <li class="minutes">0</li>
            </ul>
        </div>
        
        <div class="progress_block">
            <div class="value">0%</div>
            <div class="progress_bar_bg"><div class="progress_bar_back"><div class="progres_bar"></div></div></div>
            <span class="btn_refresh" onclick="window.location.reload(true)"></span>
            <div class="refresh_descr">Press refresh button to update</div>
        </div>
	</div><!-- #content-->

<?php
	echo("<script type=\"text/javascript\">");
	echo("showProgressBar($perc);");
	echo("showTime($days, $hours, $mins);");
	echo("</script>\n");
?>

</div><!-- #wrapper -->

<div id="footer">
	<div class="partners">
    	<a href="#" class="warmongers"><img src="img/logo_warmongers.png" height="53" width="65" alt="" title="" /></a>
    	<a href="#" class="arktos"><img src="img/logo_arktos.png" height="47" width="87" alt="" title="" /></a>
    	<a href="#" class="warinc"><img src="img/logo_warinc.png" height="54" width="154" alt="" title="" /></a>
    </div>
    
    <div class="copyright">
    	(c) 2011<br />
        All Rights Reserved<br />
        Arktos Entertaiment Group
    </div>
</div><!-- #footer -->

</body>
</html>