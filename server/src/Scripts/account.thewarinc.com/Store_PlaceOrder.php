<?php
	session_start();	

	require_once('auth.php'); 
	require_once('https_redir.php');
	require_once('Store.inc.php');
	require_once('dbinfo.inc.php');
	
	$CustomerID = $_SESSION['CustomerID'];
	$CustomerEmail = $_SESSION['CustomerEmail'];

	$x_id = $_REQUEST['itemid'];
	$x_User = $_POST['userid'];

	// get item price and desc
	list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($x_id, 0);

	$bname = $_POST['bname'];
	$baddr1 = $_POST['baddr1'];
	$bcity = $_POST['bcity'];
	$bzip = $_POST['bzip'];
	$bstate = $_POST['bstate'];
	$bcountry = $_POST['bcountry'];
	$cctype = $_POST['cctype'];
	$cardnumber = $_POST['cardnumber'];
	$expmonth = $_POST['expmonth'];
	$expyear = $_POST['expyear'];
	$CVVCode = $_POST['cvm'];
	
	// mark that we're making CC purchase
	$_SESSION['CCPurchaseInProcess'] = "1";
	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->
	<style type="text/css">
		html,
		body {
		background-color: transparent;
		background-image: none;
		bgcolor="transparent"> 
		}

	</style>
	
	<script type="text/javascript" src="js/analytics.js"></script>
	
	<SCRIPT LANGUAGE="JavaScript">
	
		function storecheck()
		{	
			if (document.storeform.legal.checked == false ) {			
				
				document.getElementById('error_legal').innerHTML = "<p class=\"must\">*You must agree to the terms.</p>";
			}
			else {
				document.getElementById('processing').innerHTML = "<center><strong>... Processing transaction. do not press any keys or back button to avoid double charges ...</strong></center><br><br><br><br>";
				document.getElementById('btn_place_order').disabled = true;
				document.getElementById('btn_place_order').style.display = 'none';
				document.storeform.submit();
			}
			
		
		}
	
	</script>
	
</head>
<body>

	<div class="shadow10_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
	
				<form name="storeform" id="storeform" action="ccpost2.php" method="post">
					
					<input name="bname" type="label" value="<?php echo $bname; ?>" style="display: none;" >
					<input name="baddr1" type="label" value="<?php echo $baddr1; ?>" style="display: none;" >
					<input name="bcity" type="label" value="<?php echo $bcity ?>" style="display: none;" >
					<input name="bzip" type="label" value="<?php echo $bzip; ?>" style="display: none;" >
					<input name="bstate" type="label" value="<?php echo $bstate; ?>" style="display: none;" >
					<input name="bcountry" type="label" value="<?php echo $bcountry; ?>" style="display: none;" >
					<input name="cctype" type="label" value="<?php echo $cctype; ?>" style="display: none;" >
					<input name="cardnumber" type="label" value="<?php echo $cardnumber; ?>" style="display: none;" >
					<input name="expmonth" type="label" value="<?php echo $expmonth; ?>" style="display: none;" >
					<input name="expyear" type="label" value="<?php echo $expyear; ?>" style="display: none;" >
					<input name="cvm" type="label" value="<?php echo $CVVCode; ?>" style="display: none;" >
					
					<input name="x_email" type="hidden" value="<?php echo $CustomerEmail; ?>">

					<?php
						echo "
						<input name=\"chargetotal\" type=\"label\" value=\"$x_price\" style=\"display: none;\" >
						<input name=\"userid\" type=\"label\" value=\"$x_User\" style=\"display: none;\" >
						<input name=\"itemid\" type=\"label\" value=\"$x_id\" style=\"display: none;\" >
						"
					?>
			
					<div class="order_info"></div>
					<div class="left_block4">	
						<div class="item"><?php echo $Item_Desc; ?></div>	
						<div class="price_1">$<?php echo $x_price; ?></div>	
					</div>
					<div class="right_block4">
						<div class="tax">$0.00</div>	
						<div class="order_total">$<?php echo $x_price; ?></div>	
					</div>
					<div class="cL"></div>
					<div class="line_10"></div>
					<div class="left_block4">
						<div class="billing_address_1"></div>	
						<div class="padding_4">
							<p class="billing">
							<?php 
								echo "
									$bname<br>
									$baddr1<br>
									$bcity, $bstate $bzip<br>";
									
							?>
							</p>
						</div>					
					</div>
					<div class="right_block4">
						<div class="billing_address_2"></div>	
						<p class="billing">Credit Card Ending in <?php echo substr($cardnumber,-4,4); ?>, expires <?php echo "$expmonth/$expyear"; ?></p>					
					</div>
					<div class="cL"></div>	
					<div class="line_6"></div>	
					<input type="checkbox" name="legal" class="checkbox"/>	
					<p class="check">You agree to <a target="_blank" href="http://www.thewarinc.com/terms.html">Terms of Service</a> *</p>
					<div class="cL"></div>	
					<div id="error_legal" style="height: 80px;" ></div>					
					<p id="processing" class="text_3"></p>
					<input id="btn_place_order" type="button" value="" onClick="storecheck();" class="place_order" />
					
					
				</form>	
			
			</div>
		</div>
	<div class="shadow10_bottom"><div class="bottom_8"></div></div>
				
			

</body>
</html>
