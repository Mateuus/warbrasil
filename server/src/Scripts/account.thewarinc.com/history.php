<?php
	
	session_start();
	require_once('https_redir.php'); 
	require_once('auth.php'); 
	require_once('store.inc.php');
	require_once('store_g1c.inc.php');
	
?>
<?php
	require_once('dbinfo.inc.php');
	
	$CustomerID = $_SESSION['CustomerID'];
	
	// GET BALANCE
	$tsql   = "SELECT GamePoints FROM LoginID WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);						

	$gamepoints=$member['GamePoints'];

	//GET PAYMENT HISTORY	
	$tsql   = "SELECT * FROM FinancialTransactions WHERE CustomerID=? and TransactionType=1000 order by DateTime desc";
	$params = array($CustomerID);
	$stmt   = sqlsrv_query($conn, $tsql, $params);

	// INIT
	$History_Date = array();	
	$History_Method = array();
	$History_Price = array();
	$History_Details = array();
	
	$i = 0;
	while($member = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC))
	{
		// date
		$History_Date[$i] = $member['DateTime'];

		// price
		$price = $member['Amount'];
		$History_Price[$i] = $price;

		// method
		$resp = $member['ResponseCode'];
		$method = $resp;
		if(substr($resp, 0, 2) == "Y:")
			$method = "Credit Card";
		if(substr($resp, 0, 6) == "PAYPAL")
			$method = "PAYPAL";
		else if(substr($resp, 0, 3) == "SMS")
			$method = "SMS";
		else if(substr($resp, 0, 5) == "STEAM")
			$method = "STEAM";
		else if(substr($resp, 0, 3) == "G1C") {
			$method = "G1 CREDITS";
			$History_Price[$i] = g1c_USDtoG1C($History_Price[$i]);
		}
		$History_Method[$i]  = $method;

		// item desc
		$desc = store_GetItemDesc($member['ItemID']);
		$History_Details[$i] = $desc;

		$i++;
	}
?>

<?php

	function show_history_row($hDate,$hMethod,$hPrice,$hDetails,$hBG) {
	
		if ($hBG == "1") {
			$hBGClass = "tr_1";
		}
		else {
			$hBGClass = "tr_2";
		}

		$hDateStr = date_format($hDate, "M d, Y H:i");
		$curenc1 = $hMethod == "G1 CREDITS" ? "" : "$";
		
		echo "
			<div class=\"$hBGClass\">
				<div class=\"td_1\">$hDateStr</div>
				<div class=\"td_2\">$hMethod</div>				
				<div class=\"td_4\">$curenc1$hPrice</div>
				<div class=\"td5_tr1\">$hDetails</div>
				<div class=\"cL\"></div>
			</div>
			";	
	}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Purchase History</title>
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
				<li class="menu_3"><a href="invitefriends.php"></a></li>
				<li class="menu_4"><a href="key.php"></a></li>
				<li class="menu_5"><a href="store.php"></a></li>
				<li class="menu_6"><a href="earn.php"></a></li>
				<li class="menu_7 active_7"><a href="history.php"></a></li>
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
				<div class="left_block1">
					<div class="shadow8_top"></div>	
					<div class="shadow8_repeat">
						<div class="block_current_balance">
							<div><img src="images/current_balance.gif" alt="" border="0px" /></div>
							<div class="line_8"></div>
							<h1><?php echo $gamepoints; ?></h1>
						</div>
					</div>
					<div class="shadow8_bottom"></div>
				</div>
				<a class="right_block1" href="store.php">
					<span></span>
				</a>
				<div class="cL"></div>
				<div class="block_table1"><a href="history.php?s=date" onClick="this.className = (this.className == 'marker_on1' ? 'marker_off1' : 'marker_on1')" class="marker_off1"><span></span></a></div>	
				<div class="block_table2"><a href="history.php?s=method" onClick="this.className = (this.className == 'marker_on2' ? 'marker_off2' : 'marker_on2')" class="marker_off2"><span></span></a></div>				
				<div class="block_table4"><a href="history.php?s=price" onClick="this.className = (this.className == 'marker_on4' ? 'marker_off4' : 'marker_on4')" class="marker_off4"><span></span></a></div>	
				<div class="block_table5"><a href="history.php?s=details" onClick="this.className = (this.className == 'marker_on5' ? 'marker_off5' : 'marker_on5')" class="marker_off5"><span></span></a></div>	
				<div class="cL"></div>
				<div class="bg_table">
					<div style="width: 100%; height: 400px; overlow: auto;" >
						
						<?php
						
							$Sort = $_GET['s'];
							
							$History_UnixTime = array();
							
							for($i=0;$i<sizeof($History_Date);$i++) {
								$History_UnixTime[$i] = date_format($History_Date[$i], "U");
							}
							
							if ($Sort == "date" || $Sort == "") {								
								array_multisort($History_UnixTime, SORT_DESC , $History_Date, $History_Method, $History_Price, $History_Details);
							}
							else if ($Sort == "method") {
								array_multisort($History_Method, $History_Date, $History_Price, $History_Details);
							}							
							else if ($Sort == "price") {
								array_multisort($History_Price, SORT_DESC, $History_Date, $History_Method, $History_Details);
							}
							else if ($Sort == "details") {
								array_multisort($History_Details, $History_Date, $History_Method, $History_Price);
							}	
							
							
							$bgToggle = "2";
							
							for($i=0;$i<sizeof($History_Date);$i++) {
							
								if ($bgToggle == "1") {
									$bgToggle = "2";
								}
								else {
									$bgToggle = "1";
								}			
							
								show_history_row($History_Date[$i],$History_Method[$i],$History_Price[$i],$History_Details[$i],$bgToggle);
							
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
