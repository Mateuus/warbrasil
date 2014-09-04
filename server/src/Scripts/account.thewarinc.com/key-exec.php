<?php
	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$userid = $_POST["userid"];
	$couponid = trim($_POST["coupon"]);
	$Last_IP = $_SERVER['REMOTE_ADDR']; 
	
	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_UseCouponPAX2011 ?, ?";
	$params = array($userid, $couponid);
	$member = db_exec($conn, $tsql, $params);
			
	$rm = $member['ResultMsg'];
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone </title>
</head>
<body>
<center>
	<span style="font-size: 14px; font-weight:bold; font-family:verdana; color:white"  >

	<br><br><br><br><br><br><br><br><br><br><br>
	<?php echo $rm ?>
</span>
</center>
</body>
</html>
