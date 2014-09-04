<?php
	
	
	session_start();	
	require_once('auth.php'); 
	require_once('https_redir.php');
	require_once('Store.inc.php');
	require_once('dbinfo.inc.php');
	
	$CustomerID = $_SESSION['CustomerID'];

	// create & execute query
	$tsql   = "SELECT * FROM AccountInfo WHERE CustomerID=?";
	$params = array($CustomerID);
	$member = db_exec($conn, $tsql, $params);
	
	$email=trim($member['email']);
	$firstname=trim($member['firstname']);
	$lastname=trim($member['lastname']);
	$street=trim($member['street']);
	$city=trim($member['city']);
	$state=trim($member['state']);
	$zip=trim($member['postalcode']);
	$country=trim($member['Country']);

	$_SESSION['CustomerEmail'] = $email;

	$x_User = $CustomerID;
	$x_id   = $_GET["ItemID"];
	// get item price and desc
	list($x_price, $Item_Desc) = store_GetItemPriceDescByCode($x_id, 0);
	
	if ($state == "")
	$state = "CA";
	
	if ($country == "")
	$country = "US";
	
	
	
	
	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Store</title>
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
	
		function Open_CVV() {
		
			document.getElementById('CVVInfo').style.display = "block";
		}
		
		function Close_CVV() {
		
			document.getElementById('CVVInfo').style.display = "none";
		}
	
		

		var error;

		function storecheck() {
		
			
			
			
			error = 0;
			
			var error_name = 0;
			var error_address = 0;
			var error_city = 0;
			var error_zip = 0;
			var error_state = 0;
			var error_country = 0;
			var error_cardtype = 0;
			var error_cardnumber = 0;
			var error_expmonth = 0;
			var error_expyear = 0;
			var error_cvv = 0;
			
			document.getElementById('error_name').innerHTML = "";
			document.getElementById('error_address').innerHTML = "";
			document.getElementById('error_city').innerHTML = "";
			document.getElementById('error_zip').innerHTML = "";
			document.getElementById('error_cardnumber').innerHTML = "";
			document.getElementById('error_cvv').innerHTML = "";
			document.getElementById('error_exp').innerHTML = "";
			
			/*
			document.getElementById('error_name').innerHTML = "test";
			document.getElementById('error_address').innerHTML = "test";
			document.getElementById('error_city').innerHTML = "test";
			document.getElementById('error_zip').innerHTML = "test";
			document.getElementById('error_cardnumber').innerHTML = "test";
			document.getElementById('error_cvv').innerHTML = "test";
			*/
			
			CheckCardNumber(document.storeform);
			
			
			if (document.storeform.bname.value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_name').innerHTML = "<span class='errortext' >*You must enter in a name.</span>";
			}
			
			
			
			if (document.storeform.baddr1.value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_address').innerHTML = "<span class='errortext' >*You must enter in an address.</span>";
			}
			
			if (document.storeform.bcity.value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_city').innerHTML = "<span class='errortext' >*You must enter in a city.</span>";
			}
			
			if (document.storeform.bzip.value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_zip').innerHTML = "<span class='errortext' >*You must enter in a zip code.</span>";
			}
			
			
			if (document.storeform.cardnumber.value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_cardnumber').innerHTML = "<span class='errortext' >*You must enter in a card number.</span>";
			
			}
			
			
			
			
			var checkYear = document.storeform.expyear.value;
			var datNow = new Date();
			var thisYear = datNow.getFullYear();
			
			if (checkYear < thisYear ) {
			
				error = 1;
				error_expyear = 1;
				
				document.getElementById('error_exp').innerHTML = "<span class='errortext' >*Year Expired.</span>";
			
			}
			else if (checkYear == thisYear ) {
			
//				var checkMonth = parseInt(document.storeform.expmonth.value);
				var checkMonth = document.storeform.expmonth.value;
				var thisMonth = datNow.getMonth();		
				thisMonth+=1;
				
//				alert(checkMonth + " "+thisMonth);

				if (checkMonth < thisMonth) {
				
					error = 1;
					error_expmonth = 1;
					
					document.getElementById('error_exp').innerHTML = "<span class='errortext' >*Month Expired.</span>";
				
				}
			
			
			}
			
			
			if (document.storeform['cvm'].value == "" ) {
			
				error = 1;
				error_name = 1;
				
				document.getElementById('error_cvv').innerHTML = "<span class='errortext' >*You must enter in cvv code.</span>";
			}
			
			
			
			if (error == 0) {
			
				document.storeform.submit();

			}
			
			
		
		
		
		
		}

	</script>

	<SCRIPT LANGUAGE="JavaScript">

		function changecountry() {
		
			if (document.storeform.bcountry[document.storeform.bcountry.selectedIndex].value == "US") {
			
				document.storeform.bstate.disabled=false; 
			}
			else {
			
				document.storeform.bstate.disabled=true; 
			}
		
		
		
		
		}

	</script>


	<script type="text/javascript" src="js/cardcheck.js"></script>
	
</head>
<body>

	
		
		
		
		
		
		
	<div class="shadow10_top"></div>	
		<div class="shadow10_repeat">
			<div class="bg_login">
		
			
				
				<form name="storeform" action="Store_PlaceOrder.php" method="post"  >
					<?php
						echo "
						<input name=\"chargetotal\" type=\"label\" value=\"$x_price\" style=\"display: none;\" >
						<input name=\"userid\" type=\"label\" value=\"$x_User\" style=\"display: none;\" >
						<input name=\"itemid\" type=\"label\" value=\"$x_id\" style=\"display: none;\" >
						";
					?>
					<div class="order_info"></div>	
					<div class="item"><?php echo $Item_Desc; ?></div>	
					<div class="price_1">$<?php echo $x_price; ?></div>	
					<div class="line_6"></div>	
					<div class="billing_address_1"></div>			
					<div class="left_block2">
						<div class="block">
							<div id="error_name" class="error_div" style="margin-left: 130px;"></div>
							<div align="right" class="img"><img src="images/name_1.gif" alt="" border="0px" /></div>
							<div class="input10"><input  type="text"  name="bname" value="" class="form_input10" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div id="error_address" class="error_div" style="margin-left: 130px;"></div>
							<div align="right" class="img"><img src="images/address_1.gif" alt="" border="0px" /></div>
							<div class="input10"><input  type="text"  name="baddr1" value="" class="form_input10" /></div>
							<div class="cL"></div>
												
						</div>
						<div class="block">
							<div id="error_city" class="error_div" style="margin-left: 130px;"></div>
							<div align="right" class="img"><img src="images/city_1.gif" alt="" border="0px" /></div>
							<div class="input10"><input  type="text"  name="bcity" value="" class="form_input10" /></div>
							<div class="cL"></div>	
							
						</div>
					</div>
					<div class="right_block2">
						<div class="block">
							<div id="error_zip" class="error_div" style="margin-left: 140px;"></div>
							<div align="right" class="img"><img src="images/zip_1.gif" alt="" border="0px" /></div>
							<div class="input10"><input  type="text"  name="bzip" value="" class="form_input10" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/state_1.gif" alt="" border="0px" /></div>
							<select id="bstate" name="bstate" class="select1_10" >
								<option value="AL" <?php if ($state == "AL") echo "selected=\"selected\""; ?> >Alabama</option>
								<option value="AK" <?php if ($state == "AK") echo "selected=\"selected\""; ?> >Alaska</option>
								<option value="AZ" <?php if ($state == "AZ") echo "selected=\"selected\""; ?> >Arizona</option>
								<option value="AR" <?php if ($state == "AR") echo "selected=\"selected\""; ?> >Arkansas</option>
								<option value="CA" <?php if ($state == "CA") echo "selected=\"selected\""; ?> >California</option>
								<option value="CO" <?php if ($state == "CO") echo "selected=\"selected\""; ?> >Colorado</option>
								<option value="CT" <?php if ($state == "CT") echo "selected=\"selected\""; ?> >Connecticut</option>
								<option value="DE" <?php if ($state == "DE") echo "selected=\"selected\""; ?> >Delaware</option>
								<option value="DC" <?php if ($state == "DC") echo "selected=\"selected\""; ?> >District Of Columbia</option>
								<option value="FL" <?php if ($state == "FL") echo "selected=\"selected\""; ?> >Florida</option>
								<option value="GA" <?php if ($state == "GA") echo "selected=\"selected\""; ?> >Georgia</option>
								<option value="HI" <?php if ($state == "HI") echo "selected=\"selected\""; ?> >Hawaii</option>
								<option value="ID" <?php if ($state == "ID") echo "selected=\"selected\""; ?> >Idaho</option>
								<option value="IL" <?php if ($state == "IL") echo "selected=\"selected\""; ?> >Illinois</option>
								<option value="IN" <?php if ($state == "IN") echo "selected=\"selected\""; ?> >Indiana</option>
								<option value="IA" <?php if ($state == "IA") echo "selected=\"selected\""; ?> >Iowa</option>
								<option value="KS" <?php if ($state == "KS") echo "selected=\"selected\""; ?> >Kansas</option>
								<option value="KY" <?php if ($state == "KY") echo "selected=\"selected\""; ?> >Kentucky</option>
								<option value="LA" <?php if ($state == "LA") echo "selected=\"selected\""; ?> >Louisiana</option>
								<option value="ME" <?php if ($state == "ME") echo "selected=\"selected\""; ?> >Maine</option>
								<option value="MD" <?php if ($state == "MD") echo "selected=\"selected\""; ?> >Maryland</option>
								<option value="MA" <?php if ($state == "MA") echo "selected=\"selected\""; ?> >Massachusetts</option>
								<option value="MI" <?php if ($state == "MI") echo "selected=\"selected\""; ?> >Michigan</option>
								<option value="MN" <?php if ($state == "MN") echo "selected=\"selected\""; ?> >Minnesota</option>
								<option value="MS" <?php if ($state == "MS") echo "selected=\"selected\""; ?> >Mississippi</option>
								<option value="MO" <?php if ($state == "MO") echo "selected=\"selected\""; ?> >Missouri</option>
								<option value="MT" <?php if ($state == "MT") echo "selected=\"selected\""; ?> >Montana</option>
								<option value="NE" <?php if ($state == "NE") echo "selected=\"selected\""; ?> >Nebraska</option>
								<option value="NV" <?php if ($state == "NV") echo "selected=\"selected\""; ?> >Nevada</option>
								<option value="NH" <?php if ($state == "NH") echo "selected=\"selected\""; ?> >New Hampshire</option>
								<option value="NJ" <?php if ($state == "NJ") echo "selected=\"selected\""; ?> >New Jersey</option>
								<option value="NM" <?php if ($state == "NM") echo "selected=\"selected\""; ?> >New Mexico</option>
								<option value="NY" <?php if ($state == "NY") echo "selected=\"selected\""; ?> >New York</option>
								<option value="NC" <?php if ($state == "NC") echo "selected=\"selected\""; ?> >North Carolina</option>
								<option value="ND" <?php if ($state == "ND") echo "selected=\"selected\""; ?> >North Dakota</option>
								<option value="OH" <?php if ($state == "OH") echo "selected=\"selected\""; ?> >Ohio</option>
								<option value="OK" <?php if ($state == "OK") echo "selected=\"selected\""; ?> >Oklahoma</option>
								<option value="OR" <?php if ($state == "OR") echo "selected=\"selected\""; ?> >Oregon</option>
								<option value="PA" <?php if ($state == "PA") echo "selected=\"selected\""; ?> >Pennsylvania</option>
								<option value="RI" <?php if ($state == "RI") echo "selected=\"selected\""; ?> >Rhode Island</option>
								<option value="SC" <?php if ($state == "SC") echo "selected=\"selected\""; ?> >South Carolina</option>
								<option value="SD" <?php if ($state == "SD") echo "selected=\"selected\""; ?> >South Dakota</option>
								<option value="TN" <?php if ($state == "TN") echo "selected=\"selected\""; ?> >Tennessee</option>
								<option value="TX" <?php if ($state == "TX") echo "selected=\"selected\""; ?> >Texas</option>
								<option value="UT" <?php if ($state == "UT") echo "selected=\"selected\""; ?> >Utah</option>
								<option value="VT" <?php if ($state == "VT") echo "selected=\"selected\""; ?> >Vermont</option>
								<option value="VA" <?php if ($state == "VA") echo "selected=\"selected\""; ?> >Virginia</option>
								<option value="WA" <?php if ($state == "WA") echo "selected=\"selected\""; ?> >Washington</option>
								<option value="WV" <?php if ($state == "WV") echo "selected=\"selected\""; ?> >West Virginia</option>
								<option value="WI" <?php if ($state == "WI") echo "selected=\"selected\""; ?> >Wisconsin</option>
								<option value="WY" <?php if ($state == "WY") echo "selected=\"selected\""; ?> >Wyoming</option>
							</select>
							
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/country_1.gif" alt="" border="0px" /></div>
							<select id="bcountry" name="bcountry" class="select1_10" onChange="Javascript: changecountry();">
								<option value="GB" <?php if ($country == "GB") echo "selected=\"selected\""; ?> >United Kingdom</option>
								<option value="US" <?php if ($country == "US") echo "selected=\"selected\""; ?> >United States</option>
								<option value="AF" <?php if ($country == "AF") echo "selected=\"selected\""; ?> >Afghanistan</option>
								<option value="AL" <?php if ($country == "AL") echo "selected=\"selected\""; ?> >Albania</option>
								<option value="DZ" <?php if ($country == "DZ") echo "selected=\"selected\""; ?> >Algeria</option>
								<option value="AS" <?php if ($country == "AS") echo "selected=\"selected\""; ?> >American Samoa</option>
								<option value="AD" <?php if ($country == "AD") echo "selected=\"selected\""; ?> >Andorra</option>
								<option value="AO" <?php if ($country == "AO") echo "selected=\"selected\""; ?> >Angola</option>
								<option value="AI" <?php if ($country == "AI") echo "selected=\"selected\""; ?> >Anguilla</option>
								<option value="AQ" <?php if ($country == "AQ") echo "selected=\"selected\""; ?> >Antarctica</option>
								<option value="AG" <?php if ($country == "AG") echo "selected=\"selected\""; ?> >Antigua And Barbuda</option>
								<option value="AR" <?php if ($country == "AR") echo "selected=\"selected\""; ?> >Argentina</option>
								<option value="AM" <?php if ($country == "AM") echo "selected=\"selected\""; ?> >Armenia</option>
								<option value="AW" <?php if ($country == "AW") echo "selected=\"selected\""; ?> >Aruba</option>
								<option value="AU" <?php if ($country == "AU") echo "selected=\"selected\""; ?> >Australia</option>
								<option value="AT" <?php if ($country == "AT") echo "selected=\"selected\""; ?> >Austria</option>
								<option value="AZ" <?php if ($country == "AZ") echo "selected=\"selected\""; ?> >Azerbaijan</option>						
								<option value="BS" <?php if ($country == "BS") echo "selected=\"selected\""; ?> >Bahamas</option>
								<option value="BH" <?php if ($country == "BH") echo "selected=\"selected\""; ?> >Bahrain</option>
								<option value="BD" <?php if ($country == "BD") echo "selected=\"selected\""; ?> >Bangladesh</option>
								<option value="BB" <?php if ($country == "BB") echo "selected=\"selected\""; ?> >Barbados</option>
								<option value="BY" <?php if ($country == "BY") echo "selected=\"selected\""; ?> >Belarus</option>
								<option value="BE" <?php if ($country == "BE") echo "selected=\"selected\""; ?> >Belgium</option>
								<option value="BZ" <?php if ($country == "BZ") echo "selected=\"selected\""; ?> >Belize</option>
								<option value="BJ" <?php if ($country == "BJ") echo "selected=\"selected\""; ?> >Benin</option>
								<option value="BM" <?php if ($country == "BM") echo "selected=\"selected\""; ?> >Bermuda</option>
								<option value="BT" <?php if ($country == "BT") echo "selected=\"selected\""; ?> >Bhutan</option>
								<option value="BO" <?php if ($country == "BO") echo "selected=\"selected\""; ?> >Bolivia</option>
								<option value="BA" <?php if ($country == "BA") echo "selected=\"selected\""; ?> >Bosnia And Herzegowina</option>
								<option value="BW" <?php if ($country == "BW") echo "selected=\"selected\""; ?> >Botswana</option>
								<option value="BV" <?php if ($country == "BV") echo "selected=\"selected\""; ?> >Bouvet Island</option>
								<option value="BR" <?php if ($country == "BR") echo "selected=\"selected\""; ?> >Brazil</option>
								<option value="IO" <?php if ($country == "IO") echo "selected=\"selected\""; ?> >British Indian Ocean Territory</option>
								<option value="BN" <?php if ($country == "BN") echo "selected=\"selected\""; ?> >Brunei Darussalam</option>
								<option value="BG" <?php if ($country == "BG") echo "selected=\"selected\""; ?> >Bulgaria</option>
								<option value="BF" <?php if ($country == "BF") echo "selected=\"selected\""; ?> >Burkina Faso</option>
								<option value="BI" <?php if ($country == "BI") echo "selected=\"selected\""; ?> >Burundi</option>
								<option value="KH" <?php if ($country == "KH") echo "selected=\"selected\""; ?> >Cambodia</option>
								<option value="CM" <?php if ($country == "CM") echo "selected=\"selected\""; ?> >Cameroon</option>
								<option value="CA" <?php if ($country == "CA") echo "selected=\"selected\""; ?> >Canada</option>
								<option value="CV" <?php if ($country == "CV") echo "selected=\"selected\""; ?> >Cape Verde</option>
								<option value="KY" <?php if ($country == "KY") echo "selected=\"selected\""; ?> >Cayman Islands</option>
								<option value="CF" <?php if ($country == "CF") echo "selected=\"selected\""; ?> >Central African Republic</option>
								<option value="TD" <?php if ($country == "TD") echo "selected=\"selected\""; ?> >Chad</option>
								<option value="CL" <?php if ($country == "CL") echo "selected=\"selected\""; ?> >Chile</option>
								<option value="CN" <?php if ($country == "CN") echo "selected=\"selected\""; ?> >China</option>
								<option value="CX" <?php if ($country == "CX") echo "selected=\"selected\""; ?> >Christmas Island</option>
								<option value="CC" <?php if ($country == "CC") echo "selected=\"selected\""; ?> >Cocos (Keeling) Islands</option>
								<option value="CO" <?php if ($country == "CO") echo "selected=\"selected\""; ?> >Colombia</option>
								<option value="KM" <?php if ($country == "KM") echo "selected=\"selected\""; ?> >Comoros</option>
								<option value="CG" <?php if ($country == "CG") echo "selected=\"selected\""; ?> >Congo</option>
								<option value="CD" <?php if ($country == "CD") echo "selected=\"selected\""; ?> >Congo, The Democratic Republic Of The</option>
								<option value="CK" <?php if ($country == "CK") echo "selected=\"selected\""; ?> >Cook Islands</option>
								<option value="CR" <?php if ($country == "CR") echo "selected=\"selected\""; ?> >Costa Rica</option>
								<option value="CI" <?php if ($country == "CI") echo "selected=\"selected\""; ?> >Cote D'Ivoire</option>
								<option value="HR" <?php if ($country == "HR") echo "selected=\"selected\""; ?> >Croatia</option>
								<option value="CU" <?php if ($country == "CU") echo "selected=\"selected\""; ?> >Cuba</option>
								<option value="CY" <?php if ($country == "CY") echo "selected=\"selected\""; ?> >Cyprus</option>
								<option value="CZ" <?php if ($country == "CZ") echo "selected=\"selected\""; ?> >Czech Republic</option>
								<option value="DK" <?php if ($country == "DK") echo "selected=\"selected\""; ?> >Denmark</option>
								<option value="DJ" <?php if ($country == "DJ") echo "selected=\"selected\""; ?> >Djibouti</option>
								<option value="DM" <?php if ($country == "DM") echo "selected=\"selected\""; ?> >Dominica</option>
								<option value="DO" <?php if ($country == "DO") echo "selected=\"selected\""; ?> >Dominican Republic</option>
								<option value="TP" <?php if ($country == "TP") echo "selected=\"selected\""; ?> >East Timor</option>
								<option value="EC" <?php if ($country == "EC") echo "selected=\"selected\""; ?> >Ecuador</option>
								<option value="EG" <?php if ($country == "EG") echo "selected=\"selected\""; ?> >Egypt</option>
								<option value="SV" <?php if ($country == "SV") echo "selected=\"selected\""; ?> >El Salvador</option>
								<option value="GQ" <?php if ($country == "GQ") echo "selected=\"selected\""; ?> >Equatorial Guinea</option>
								<option value="ER" <?php if ($country == "ER") echo "selected=\"selected\""; ?> >Eritrea</option>
								<option value="EE" <?php if ($country == "EE") echo "selected=\"selected\""; ?> >Estonia</option>
								<option value="ET" <?php if ($country == "ET") echo "selected=\"selected\""; ?> >Ethiopia</option>
								<option value="FK" <?php if ($country == "FK") echo "selected=\"selected\""; ?> >Falkland Islands (Malvinas)</option>
								<option value="FO" <?php if ($country == "FO") echo "selected=\"selected\""; ?> >Faroe Islands</option>
								<option value="FJ" <?php if ($country == "FJ") echo "selected=\"selected\""; ?> >Fiji</option>
								<option value="FI" <?php if ($country == "FI") echo "selected=\"selected\""; ?> >Finland</option>
								<option value="FR" <?php if ($country == "FR") echo "selected=\"selected\""; ?> >France</option>
								<option value="FX" <?php if ($country == "FX") echo "selected=\"selected\""; ?> >France, Metropolitan</option>
								<option value="GF" <?php if ($country == "GF") echo "selected=\"selected\""; ?> >French Guiana</option>
								<option value="PF" <?php if ($country == "PF") echo "selected=\"selected\""; ?> >French Polynesia</option>
								<option value="TF" <?php if ($country == "TF") echo "selected=\"selected\""; ?> >French Southern Territories</option>
								<option value="GA" <?php if ($country == "GA") echo "selected=\"selected\""; ?> >Gabon</option>
								<option value="GM" <?php if ($country == "GM") echo "selected=\"selected\""; ?> >Gambia</option>
								<option value="GE" <?php if ($country == "GE") echo "selected=\"selected\""; ?> >Georgia</option>
								<option value="DE" <?php if ($country == "DE") echo "selected=\"selected\""; ?> >Germany</option>
								<option value="GH" <?php if ($country == "GH") echo "selected=\"selected\""; ?> >Ghana</option>
								<option value="GI" <?php if ($country == "GI") echo "selected=\"selected\""; ?> >Gibraltar</option>
								<option value="GR" <?php if ($country == "GR") echo "selected=\"selected\""; ?> >Greece</option>
								<option value="GL" <?php if ($country == "GL") echo "selected=\"selected\""; ?> >Greenland</option>
								<option value="GD" <?php if ($country == "GD") echo "selected=\"selected\""; ?> >Grenada</option>
								<option value="GP" <?php if ($country == "GP") echo "selected=\"selected\""; ?> >Guadeloupe</option>
								<option value="GU" <?php if ($country == "GU") echo "selected=\"selected\""; ?> >Guam</option>
								<option value="GT" <?php if ($country == "GT") echo "selected=\"selected\""; ?> >Guatemala</option>
								<option value="GN" <?php if ($country == "GN") echo "selected=\"selected\""; ?> >Guinea</option>
								<option value="GW" <?php if ($country == "GW") echo "selected=\"selected\""; ?> >Guinea-Bissau</option>
								<option value="GY" <?php if ($country == "GY") echo "selected=\"selected\""; ?> >Guyana</option>
								<option value="HT" <?php if ($country == "HT") echo "selected=\"selected\""; ?> >Haiti</option>
								<option value="HM" <?php if ($country == "HM") echo "selected=\"selected\""; ?> >Heard And Mc Donald Islands</option>
								<option value="VA" <?php if ($country == "VA") echo "selected=\"selected\""; ?> >Holy See (Vatican City State)</option>
								<option value="HN" <?php if ($country == "HN") echo "selected=\"selected\""; ?> >Honduras</option>
								<option value="HK" <?php if ($country == "HK") echo "selected=\"selected\""; ?> >Hong Kong</option>
								<option value="HU" <?php if ($country == "HU") echo "selected=\"selected\""; ?> >Hungary</option>
								<option value="IS" <?php if ($country == "IS") echo "selected=\"selected\""; ?> >Iceland</option>
								<option value="IN" <?php if ($country == "IN") echo "selected=\"selected\""; ?> >India</option>
								<option value="ID" <?php if ($country == "ID") echo "selected=\"selected\""; ?> >Indonesia</option>
								<option value="IR" <?php if ($country == "IR") echo "selected=\"selected\""; ?> >Iran (Islamic Republic Of)</option>
								<option value="IQ" <?php if ($country == "IQ") echo "selected=\"selected\""; ?> >Iraq</option>
								<option value="IE" <?php if ($country == "IE") echo "selected=\"selected\""; ?> >Ireland</option>
								<option value="IL" <?php if ($country == "IL") echo "selected=\"selected\""; ?> >Israel</option>
								<option value="IT" <?php if ($country == "IT") echo "selected=\"selected\""; ?> >Italy</option>
								<option value="JM" <?php if ($country == "JM") echo "selected=\"selected\""; ?> >Jamaica</option>
								<option value="JP" <?php if ($country == "JP") echo "selected=\"selected\""; ?> >Japan</option>
								<option value="JO" <?php if ($country == "JO") echo "selected=\"selected\""; ?> >Jordan</option>
								<option value="KZ" <?php if ($country == "KZ") echo "selected=\"selected\""; ?> >Kazakhstan</option>
								<option value="KE" <?php if ($country == "KE") echo "selected=\"selected\""; ?> >Kenya</option>
								<option value="KI" <?php if ($country == "KI") echo "selected=\"selected\""; ?> >Kiribati</option>
								<option value="KP" <?php if ($country == "KP") echo "selected=\"selected\""; ?> >Korea, Democratic People's Republic Of</option>
								<option value="KR" <?php if ($country == "KR") echo "selected=\"selected\""; ?> >Korea, Republic Of</option>
								<option value="KW" <?php if ($country == "KW") echo "selected=\"selected\""; ?> >Kuwait</option>
								<option value="KG" <?php if ($country == "KG") echo "selected=\"selected\""; ?> >Kyrgyzstan</option>
								<option value="LA" <?php if ($country == "LA") echo "selected=\"selected\""; ?> >Lao People's Democratic Republic</option>
								<option value="LV" <?php if ($country == "LV") echo "selected=\"selected\""; ?> >Latvia</option>
								<option value="LB" <?php if ($country == "LB") echo "selected=\"selected\""; ?> >Lebanon</option>
								<option value="LS" <?php if ($country == "LS") echo "selected=\"selected\""; ?> >Lesotho</option>
								<option value="LR" <?php if ($country == "LR") echo "selected=\"selected\""; ?> >Liberia</option>
								<option value="LY" <?php if ($country == "LY") echo "selected=\"selected\""; ?> >Libyan Arab Jamahiriya</option>
								<option value="LI" <?php if ($country == "LI") echo "selected=\"selected\""; ?> >Liechtenstein</option>
								<option value="LT" <?php if ($country == "LT") echo "selected=\"selected\""; ?> >Lithuania</option>
								<option value="LU" <?php if ($country == "LU") echo "selected=\"selected\""; ?> >Luxembourg</option>
								<option value="MO" <?php if ($country == "MO") echo "selected=\"selected\""; ?> >Macau</option>
								<option value="MK" <?php if ($country == "MK") echo "selected=\"selected\""; ?> >Macedonia, Former Yugoslav Republic Of</option>
								<option value="MG" <?php if ($country == "MG") echo "selected=\"selected\""; ?> >Madagascar</option>
								<option value="MW" <?php if ($country == "MW") echo "selected=\"selected\""; ?> >Malawi</option>
								<option value="MY" <?php if ($country == "MY") echo "selected=\"selected\""; ?> >Malaysia</option>
								<option value="MV" <?php if ($country == "MV") echo "selected=\"selected\""; ?> >Maldives</option>
								<option value="ML" <?php if ($country == "ML") echo "selected=\"selected\""; ?> >Mali</option>
								<option value="MT" <?php if ($country == "MT") echo "selected=\"selected\""; ?> >Malta</option>
								<option value="MH" <?php if ($country == "MH") echo "selected=\"selected\""; ?> >Marshall Islands</option>
								<option value="MQ" <?php if ($country == "MQ") echo "selected=\"selected\""; ?> >Martinique</option>
								<option value="MR" <?php if ($country == "MR") echo "selected=\"selected\""; ?> >Mauritania</option>
								<option value="MU" <?php if ($country == "MU") echo "selected=\"selected\""; ?> >Mauritius</option>
								<option value="YT" <?php if ($country == "YT") echo "selected=\"selected\""; ?> >Mayotte</option>
								<option value="MX" <?php if ($country == "MX") echo "selected=\"selected\""; ?> >Mexico</option>
								<option value="FM" <?php if ($country == "FM") echo "selected=\"selected\""; ?> >Micronesia, Federated States Of</option>
								<option value="MD" <?php if ($country == "MD") echo "selected=\"selected\""; ?> >Moldova, Republic Of</option>
								<option value="MC" <?php if ($country == "MC") echo "selected=\"selected\""; ?> >Monaco</option>
								<option value="MN" <?php if ($country == "MN") echo "selected=\"selected\""; ?> >Mongolia</option>
								<option value="MS" <?php if ($country == "MS") echo "selected=\"selected\""; ?> >Montserrat</option>
								<option value="MA" <?php if ($country == "MA") echo "selected=\"selected\""; ?> >Morocco</option>
								<option value="MZ" <?php if ($country == "MZ") echo "selected=\"selected\""; ?> >Mozambique</option>
								<option value="MM" <?php if ($country == "MM") echo "selected=\"selected\""; ?> >Myanmar</option>
								<option value="NA" <?php if ($country == "NA") echo "selected=\"selected\""; ?> >Namibia</option>
								<option value="NR" <?php if ($country == "NR") echo "selected=\"selected\""; ?> >Nauru</option>
								<option value="NP" <?php if ($country == "NP") echo "selected=\"selected\""; ?> >Nepal</option>
								<option value="NL" <?php if ($country == "NL") echo "selected=\"selected\""; ?> >Netherlands</option>
								<option value="AN" <?php if ($country == "AN") echo "selected=\"selected\""; ?> >Netherlands Antilles</option>
								<option value="NC" <?php if ($country == "NC") echo "selected=\"selected\""; ?> >New Caledonia</option>
								<option value="NZ" <?php if ($country == "NZ") echo "selected=\"selected\""; ?> >New Zealand</option>
								<option value="NI" <?php if ($country == "NI") echo "selected=\"selected\""; ?> >Nicaragua</option>
								<option value="NE" <?php if ($country == "NE") echo "selected=\"selected\""; ?> >Niger</option>
								<option value="NG" <?php if ($country == "NG") echo "selected=\"selected\""; ?> >Nigeria</option>
								<option value="NU" <?php if ($country == "NU") echo "selected=\"selected\""; ?> >Niue</option>
								<option value="NF" <?php if ($country == "NF") echo "selected=\"selected\""; ?> >Norfolk Island</option>
								<option value="MP" <?php if ($country == "MP") echo "selected=\"selected\""; ?> >Northern Mariana Islands</option>
								<option value="NO" <?php if ($country == "NO") echo "selected=\"selected\""; ?> >Norway</option>
								<option value="OM" <?php if ($country == "OM") echo "selected=\"selected\""; ?> >Oman</option>
								<option value="PK" <?php if ($country == "PK") echo "selected=\"selected\""; ?> >Pakistan</option>
								<option value="PW" <?php if ($country == "PW") echo "selected=\"selected\""; ?> >Palau</option>
								<option value="PA" <?php if ($country == "PA") echo "selected=\"selected\""; ?> >Panama</option>
								<option value="PG" <?php if ($country == "PG") echo "selected=\"selected\""; ?> >Papua New Guinea</option>
								<option value="PY" <?php if ($country == "PY") echo "selected=\"selected\""; ?> >Paraguay</option>
								<option value="PE" <?php if ($country == "PE") echo "selected=\"selected\""; ?> >Peru</option>
								<option value="PH" <?php if ($country == "PH") echo "selected=\"selected\""; ?> >Philippines</option>
								<option value="PN" <?php if ($country == "PN") echo "selected=\"selected\""; ?> >Pitcairn</option>
								<option value="PL" <?php if ($country == "PL") echo "selected=\"selected\""; ?> >Poland</option>
								<option value="PT" <?php if ($country == "PT") echo "selected=\"selected\""; ?> >Portugal</option>
								<option value="PR" <?php if ($country == "PR") echo "selected=\"selected\""; ?> >Puerto Rico</option>
								<option value="QA" <?php if ($country == "QA") echo "selected=\"selected\""; ?> >Qatar</option>
								<option value="RE" <?php if ($country == "RE") echo "selected=\"selected\""; ?> >Reunion</option>
								<option value="RO" <?php if ($country == "RO") echo "selected=\"selected\""; ?> >Romania</option>
								<option value="RU" <?php if ($country == "RU") echo "selected=\"selected\""; ?> >Russian Federation</option>
								<option value="RW" <?php if ($country == "RW") echo "selected=\"selected\""; ?> >Rwanda</option>
								<option value="KN" <?php if ($country == "KN") echo "selected=\"selected\""; ?> >Saint Kitts And Nevis</option>
								<option value="LC" <?php if ($country == "LC") echo "selected=\"selected\""; ?> >Saint Lucia</option>
								<option value="VC" <?php if ($country == "VC") echo "selected=\"selected\""; ?> >Saint Vincent And The Grenadines</option>
								<option value="WS" <?php if ($country == "WS") echo "selected=\"selected\""; ?> >Samoa</option>
								<option value="SM" <?php if ($country == "SM") echo "selected=\"selected\""; ?> >San Marino</option>
								<option value="ST" <?php if ($country == "ST") echo "selected=\"selected\""; ?> >Sao Tome And Principe</option>
								<option value="SA" <?php if ($country == "SA") echo "selected=\"selected\""; ?> >Saudi Arabia</option>
								<option value="SN" <?php if ($country == "SN") echo "selected=\"selected\""; ?> >Senegal</option>
								<option value="SC" <?php if ($country == "SC") echo "selected=\"selected\""; ?> >Seychelles</option>
								<option value="SL" <?php if ($country == "SL") echo "selected=\"selected\""; ?> >Sierra Leone</option>
								<option value="SG" <?php if ($country == "SG") echo "selected=\"selected\""; ?> >Singapore</option>
								<option value="SK" <?php if ($country == "SK") echo "selected=\"selected\""; ?> >Slovakia (Slovak Republic)</option>
								<option value="SI" <?php if ($country == "SI") echo "selected=\"selected\""; ?> >Slovenia</option>
								<option value="SB" <?php if ($country == "SB") echo "selected=\"selected\""; ?> >Solomon Islands</option>
								<option value="SO" <?php if ($country == "SO") echo "selected=\"selected\""; ?> >Somalia</option>
								<option value="ZA" <?php if ($country == "ZA") echo "selected=\"selected\""; ?> >South Africa</option>
								<option value="GS" <?php if ($country == "GS") echo "selected=\"selected\""; ?> >South Georgia, South Sandwich Islands</option>
								<option value="ES" <?php if ($country == "ES") echo "selected=\"selected\""; ?> >Spain</option>
								<option value="LK" <?php if ($country == "LK") echo "selected=\"selected\""; ?> >Sri Lanka</option>
								<option value="SH" <?php if ($country == "SH") echo "selected=\"selected\""; ?> >St. Helena</option>
								<option value="PM" <?php if ($country == "PM") echo "selected=\"selected\""; ?> >St. Pierre And Miquelon</option>
								<option value="SD" <?php if ($country == "SD") echo "selected=\"selected\""; ?> >Sudan</option>
								<option value="SR" <?php if ($country == "SR") echo "selected=\"selected\""; ?> >Suriname</option>
								<option value="SJ" <?php if ($country == "SJ") echo "selected=\"selected\""; ?> >Svalbard And Jan Mayen Islands</option>
								<option value="SZ" <?php if ($country == "SZ") echo "selected=\"selected\""; ?> >Swaziland</option>
								<option value="SE" <?php if ($country == "SE") echo "selected=\"selected\""; ?> >Sweden</option>
								<option value="CH" <?php if ($country == "CH") echo "selected=\"selected\""; ?> >Switzerland</option>
								<option value="SY" <?php if ($country == "SY") echo "selected=\"selected\""; ?> >Syrian Arab Republic</option>
								<option value="TW" <?php if ($country == "TW") echo "selected=\"selected\""; ?> >Taiwan</option>
								<option value="TJ" <?php if ($country == "TJ") echo "selected=\"selected\""; ?> >Tajikistan</option>
								<option value="TZ" <?php if ($country == "TZ") echo "selected=\"selected\""; ?> >Tanzania, United Republic Of</option>
								<option value="TH" <?php if ($country == "TH") echo "selected=\"selected\""; ?> >Thailand</option>
								<option value="TG" <?php if ($country == "TG") echo "selected=\"selected\""; ?> >Togo</option>
								<option value="TK" <?php if ($country == "TK") echo "selected=\"selected\""; ?> >Tokelau</option>
								<option value="TO" <?php if ($country == "TO") echo "selected=\"selected\""; ?> >Tonga</option>
								<option value="TT" <?php if ($country == "TT") echo "selected=\"selected\""; ?> >Trinidad And Tobago</option>
								<option value="TN" <?php if ($country == "TN") echo "selected=\"selected\""; ?> >Tunisia</option>
								<option value="TR" <?php if ($country == "TR") echo "selected=\"selected\""; ?> >Turkey</option>
								<option value="TM" <?php if ($country == "TM") echo "selected=\"selected\""; ?> >Turkmenistan</option>
								<option value="TC" <?php if ($country == "TC") echo "selected=\"selected\""; ?> >Turks And Caicos Islands</option>
								<option value="TV" <?php if ($country == "TV") echo "selected=\"selected\""; ?> >Tuvalu</option>
								<option value="UG" <?php if ($country == "UG") echo "selected=\"selected\""; ?> >Uganda</option>
								<option value="UA" <?php if ($country == "UA") echo "selected=\"selected\""; ?> >Ukraine</option>
								<option value="AE" <?php if ($country == "AE") echo "selected=\"selected\""; ?> >United Arab Emirates</option>
								<option value="UM" <?php if ($country == "UM") echo "selected=\"selected\""; ?> >United States Minor Outlying Islands</option>
								<option value="UY" <?php if ($country == "UY") echo "selected=\"selected\""; ?> >Uruguay</option>
								<option value="UZ" <?php if ($country == "UZ") echo "selected=\"selected\""; ?> >Uzbekistan</option>
								<option value="VU" <?php if ($country == "VU") echo "selected=\"selected\""; ?> >Vanuatu</option>
								<option value="VE" <?php if ($country == "VE") echo "selected=\"selected\""; ?> >Venezuela</option>
								<option value="VN" <?php if ($country == "VN") echo "selected=\"selected\""; ?> >Viet Nam</option>
								<option value="VG" <?php if ($country == "VG") echo "selected=\"selected\""; ?> >Virgin Islands (British)</option>
								<option value="VI" <?php if ($country == "VI") echo "selected=\"selected\""; ?> >Virgin Islands (U.S.)</option>
								<option value="WF" <?php if ($country == "WF") echo "selected=\"selected\""; ?> >Wallis And Futuna Islands</option>
								<option value="EH" <?php if ($country == "EH") echo "selected=\"selected\""; ?> >Western Sahara</option>
								<option value="YE" <?php if ($country == "YE") echo "selected=\"selected\""; ?> >Yemen</option>
								<option value="YU" <?php if ($country == "YU") echo "selected=\"selected\""; ?> >Yugoslavia</option>
								<option value="ZM" <?php if ($country == "ZM") echo "selected=\"selected\""; ?> >Zambia</option>
								<option value="ZW" <?php if ($country == "ZW") echo "selected=\"selected\""; ?> >Zimbabwe</option>
							</select>
							
							<div class="cL"></div>	
						</div>
					</div>
					<div class="cL"></div>
					<div class="line_6"></div>				
					<div class="billing_address"></div>	
					<div class="left_block2">
						<div class="block">
							<div align="right" class="img"><img src="images/card_type.gif" alt="" border="0px" /></div>
							<select id="cctype" name="cctype" class="select2_10">
								<option value="V" selected="selected">Visa</option>
								<option value="M">Mastercard</option>
								<option value="A">American Express</option>
								<option value="D">Discover</option>
								<option value="C">Diner's Club</option>
								<option value="J">JCB</option>
							</select>
							<div class="cL"></div>	
						</div>
						<div class="block">	
							<div id="error_cardnumber" class="error_div" style="margin-left: 130px;" ></div>
							<div align="right" class="img"><img src="images/card_number.gif" alt="" border="0px" /></div>
							<div class="input10"><input  type="text"  name="cardnumber" value="" class="form_input10" /></div>
							<div class="cL"></div>	
							
						</div>
					</div>
					<div class="right_block3">
						<div class="block">	
							<div id="error_exp" style="margin-left: 140px;" ></div>
							<div align="right" class="expiration"><img src="images/expiration.gif" alt="" border="0px" /></div>
							<select id="expmonth" name="expmonth" class="select3_10">
								<option value="01" selected="selected" >01</option>
									<option value="02"  >02</option>
									<option value="03"  >03</option>
									<option value="04"  >04</option>
									<option value="05"  >05</option>
									<option value="06"  >06</option>
									<option value="07"  >07</option>
									<option value="08"  >08</option>
									<option value="09"  >09</option>
									<option value="10"  >10</option>
									<option value="11"  >11</option>
									<option value="12"  >12</option>
							</select>
							<div align="right" class="year_1"><img src="images/year.gif" alt="" border="0px" /></div>
							<select id="expyear" name="expyear" class="select3_10">
									<option value="2012" selected="selected">2012</option>	
									<option value="2013" >2013</option>	
									<option value="2014" >2014</option>	
									<option value="2015" >2015</option>	
									<option value="2016" >2016</option>	
									<option value="2017" >2017</option>	
									<option value="2018" >2018</option>	
									<option value="2019" >2019</option>	
									<option value="2020" >2020</option>	
									<option value="2021" >2021</option>	
									<option value="2022" >2022</option>	
								</select>
							<div class="cL"></div>	
						</div>
						<div class="block">	
							<div align="right" class="cvv_code"><img src="images/cvv_code.gif" alt="" border="0px" /></div>
							<div id="error_cvv" ></div>
							<div class="input11"><input  type="text"  name="cvm" value="" class="form_input11" /></div>
							<a href="#" class="what_this">
							<span>
							<div style="background: #FFFFFF; width: 100%; padding: 5px; color: #000; border: 1px solid #000;" >
							For your protection, the Card Security Code (CSC) is the 3 or 4 digit code on the front or back of a credit card used to fight credit card fraud.  See below to find the CSC code on your credit card.<br>
							<table>
							<tr>
							  <td>
								<img src="images/img_mastercard_cvv.gif" border="0" ><br>
								If you are using a Visa, MasterCard or Discover Card, please enter in the CVV2 Code field, the 3-digit CVV (Customer Verification Value). This is the non-embossed number printed on the signature panel on the back of the card immediately following the Visa, MC, or Discover card account number. 
							  </td>
							  <td>
								<img src="images/img_amex_cid.gif" border="0" ><br>
								If your credit card is an American Express card please enter in the CVV2 Code field, the 4-digit CID (Confidential Identifier Number). This is the 4 digit, non-embossed number printed above your account number on the face of your card. 
							  </td>
							</tr>
							</table>
							<!--<img src="images/02_img_1.jpg" width="300" height="200"  alt="" border="0px" />-->
							</div>
							</span>
							</a>
							<div class="cL"></div>
							
						</div>
					</div>
					<div class="cL"></div>			
					<input type="button" value="" onClick="storecheck();" class="continue" />
				</form>	
			
	
	
			</div>
		</div>
	<div class="shadow10_bottom"><div class="bottom_8"></div></div>
			


</div>
</body>
</html>
