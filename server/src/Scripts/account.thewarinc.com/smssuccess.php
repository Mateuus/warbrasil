<?php
	$param      = $_REQUEST['param'];
	$arr_custom = explode(":", $param);

	$CustomerID = $arr_custom[0];
	$itemCode   = $arr_custom[1];
	$itemPrice  = $arr_custom[2];
	$email      = $arr_custom[3];
	$geoIpCode  = $arr_custom[4];

	$trxid      = $_REQUEST['trx-id'];
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<?php require_once('config.php'); ?>
	<?php require_once('title.php'); ?>
	<?php require_once('meta.php'); ?>
	<?php require_once('style.php'); ?>	
	
	<script src="js/rollovers.js" type="text/javascript"></script>
</head>	

<body>

<span style="font-size: 16px;">

	<br><br>
	Thank you for your purchase!<br><br>
	You will receive e-mail to <?php echo $email; ?> when we finish processing your order.<br>
	It might take up to few hours.<br>
	<br>
	Please keep your order number <b><?php echo $trxid;?></b> for future reference.<br>
	<br><br><br>

</span>

</body>
</html>
