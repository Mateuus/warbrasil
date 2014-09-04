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

	//NEWSLETTER - reverse logic, if OptOut1>0 then it's disabled
	$News = $member['OptOut1'];
	if($News > 0) $News = 0; else $News = 1;
	
	$explodedob = explode(" ",$dob);
	$dob_month = $explodedob[0];
	$dob_day = $explodedob[1];
	$dob_year = $explodedob[2];

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

	if ($state == "")
	$state = "CA";
	
	if ($country == "")
	$country = "US";
	
	if ($dob_month == "")
	$dob_month = "Jan";
	
	if ($dob_day == "")
	$dob_day = "23";
	
	if ($dob_year == "")
	$dob_year = "1980";
	
	$FacebookLink = "";
	$TwitterLink = "";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>War Inc. Battlezone - Edit Profile</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<!--[if IE]>
<link href="style_ie.css" rel="stylesheet" type="text/css">
<![endif]-->
<script type="text/javascript" src="js/analytics.js"></script>
	<SCRIPT LANGUAGE="JavaScript">

	function changecountry() {
	
		if (document.Search1.country[document.Search1.country.selectedIndex].value == "US") {
		
			document.Search1.state.disabled=false; 
		}
		else {
		
			document.Search1.state.disabled=true; 
		}
	
	
	
	
	}

	</script>
	

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
				<li class="menu_2  active_2"><a href="profile.php"></a></li>
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
				<form name="Search1" action="profile-edit-exec.php" method="post"  >
					<div class="fL_names3">
						<div class="block">
							<div align="right" class="img"><img src="images/first_name.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="firstname" value="<?php echo $firstname; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/last_name.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="lastname" value="<?php echo $lastname; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<!--
						<div class="block">
							<div align="right" class="img"><img src="images/gamertag.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="q" value="Gamertag Gamertag" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						-->
						<div class="block">
							<div align="right" class="img"><img src="images/e-mail_address.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="email" value="<?php echo $email; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/sex.gif" alt="" border="0px" /></div>
							<div class="select">
								<select id="sex" name="sex" class="select_1" >
									<option value="0" <?php if ($sex == "0") echo "selected=\"selected\""; ?> >Male</option>
									<option value="1" <?php if ($sex == "1") echo "selected=\"selected\""; ?> >Female</option>
								</select>
							</div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/date_of_birth.gif" alt="" border="0px" /></div>
							<div class="select">
														   
							    <select id="dob_month" name="dob_month"  class="select_1" >
									<option value="Jan" <?php if ($dob_month == "Jan") echo "selected=\"selected\""; ?> >January</option>
									<option value="Feb" <?php if ($dob_month == "Feb") echo "selected=\"selected\""; ?> >February</option>
									<option value="Mar" <?php if ($dob_month == "Mar") echo "selected=\"selected\""; ?> >March</option>
									<option value="Apr" <?php if ($dob_month == "Apr") echo "selected=\"selected\""; ?> >April</option>
									<option value="May" <?php if ($dob_month == "May") echo "selected=\"selected\""; ?> >May</option>
									<option value="Jun" <?php if ($dob_month == "Jun") echo "selected=\"selected\""; ?> >June</option>
									<option value="Jul" <?php if ($dob_month == "Jul") echo "selected=\"selected\""; ?> >July</option>
									<option value="Aug" <?php if ($dob_month == "Aug") echo "selected=\"selected\""; ?> >August</option>
									<option value="Sep" <?php if ($dob_month == "Sep") echo "selected=\"selected\""; ?> >September</option>
									<option value="Oct" <?php if ($dob_month == "Oct") echo "selected=\"selected\""; ?> >October</option>
									<option value="Nov" <?php if ($dob_month == "Nov") echo "selected=\"selected\""; ?> >November</option>
									<option value="Dec" <?php if ($dob_month == "Dec") echo "selected=\"selected\""; ?> >December</option>
								</select>
								
														
								<select id="dob_day" name="dob_day"  class="select_2">
									<option value="1" <?php if ($dob_day == "1") echo "selected=\"selected\""; ?> >1</option>
									<option value="2" <?php if ($dob_day == "2") echo "selected=\"selected\""; ?> >2</option>
									<option value="3" <?php if ($dob_day == "3") echo "selected=\"selected\""; ?> >3</option>
									<option value="4" <?php if ($dob_day == "4") echo "selected=\"selected\""; ?> >4</option>
									<option value="5" <?php if ($dob_day == "5") echo "selected=\"selected\""; ?> >5</option>
									<option value="6" <?php if ($dob_day == "6") echo "selected=\"selected\""; ?> >6</option>
									<option value="7" <?php if ($dob_day == "7") echo "selected=\"selected\""; ?> >7</option>
									<option value="8" <?php if ($dob_day == "8") echo "selected=\"selected\""; ?> >8</option>
									<option value="9" <?php if ($dob_day == "9") echo "selected=\"selected\""; ?> >9</option>
									<option value="10" <?php if ($dob_day == "10") echo "selected=\"selected\""; ?> >10</option>
									<option value="11" <?php if ($dob_day == "11") echo "selected=\"selected\""; ?> >11</option>
									<option value="12" <?php if ($dob_day == "12") echo "selected=\"selected\""; ?> >12</option>
									<option value="13" <?php if ($dob_day == "13") echo "selected=\"selected\""; ?> >13</option>
									<option value="14" <?php if ($dob_day == "14") echo "selected=\"selected\""; ?> >14</option>
									<option value="15" <?php if ($dob_day == "15") echo "selected=\"selected\""; ?> >15</option>
									<option value="16" <?php if ($dob_day == "16") echo "selected=\"selected\""; ?> >16</option>
									<option value="17" <?php if ($dob_day == "17") echo "selected=\"selected\""; ?> >17</option>
									<option value="18" <?php if ($dob_day == "18") echo "selected=\"selected\""; ?> >18</option>
									<option value="19" <?php if ($dob_day == "19") echo "selected=\"selected\""; ?> >19</option>
									<option value="20" <?php if ($dob_day == "20") echo "selected=\"selected\""; ?> >20</option>
									<option value="21" <?php if ($dob_day == "21") echo "selected=\"selected\""; ?> >21</option>
									<option value="22" <?php if ($dob_day == "22") echo "selected=\"selected\""; ?> >22</option>
									<option value="23" <?php if ($dob_day == "23") echo "selected=\"selected\""; ?> >23</option>
									<option value="24" <?php if ($dob_day == "24") echo "selected=\"selected\""; ?> >24</option>
									<option value="25" <?php if ($dob_day == "25") echo "selected=\"selected\""; ?> >25</option>
									<option value="26" <?php if ($dob_day == "26") echo "selected=\"selected\""; ?> >26</option>
									<option value="27" <?php if ($dob_day == "27") echo "selected=\"selected\""; ?> >27</option>
									<option value="28" <?php if ($dob_day == "28") echo "selected=\"selected\""; ?> >28</option>
									<option value="29" <?php if ($dob_day == "29") echo "selected=\"selected\""; ?> >29</option>
									<option value="30" <?php if ($dob_day == "30") echo "selected=\"selected\""; ?> >30</option>
									<option value="31" <?php if ($dob_day == "31") echo "selected=\"selected\""; ?> >31</option>				
								</select>
								
																
								<select id="dob_year" name="dob_year" class="select_3">
									<option value="1901" <?php if ($dob_year == "1901") echo "selected=\"selected\""; ?> >1901</option>	
									<option value="1902" <?php if ($dob_year == "1902") echo "selected=\"selected\""; ?> >1902</option>	
									<option value="1903" <?php if ($dob_year == "1903") echo "selected=\"selected\""; ?> >1903</option>	
									<option value="1904" <?php if ($dob_year == "1904") echo "selected=\"selected\""; ?> >1904</option>	
									<option value="1905" <?php if ($dob_year == "1905") echo "selected=\"selected\""; ?> >1905</option>	
									<option value="1906" <?php if ($dob_year == "1906") echo "selected=\"selected\""; ?> >1906</option>	
									<option value="1907" <?php if ($dob_year == "1907") echo "selected=\"selected\""; ?> >1907</option>	
									<option value="1908" <?php if ($dob_year == "1908") echo "selected=\"selected\""; ?> >1908</option>	
									<option value="1909" <?php if ($dob_year == "1909") echo "selected=\"selected\""; ?> >1909</option>	
									<option value="1910" <?php if ($dob_year == "1910") echo "selected=\"selected\""; ?> >1910</option>	
									<option value="1911" <?php if ($dob_year == "1911") echo "selected=\"selected\""; ?> >1911</option>	
									<option value="1912" <?php if ($dob_year == "1912") echo "selected=\"selected\""; ?> >1912</option>	
									<option value="1913" <?php if ($dob_year == "1913") echo "selected=\"selected\""; ?> >1913</option>	
									<option value="1914" <?php if ($dob_year == "1914") echo "selected=\"selected\""; ?> >1914</option>	
									<option value="1915" <?php if ($dob_year == "1915") echo "selected=\"selected\""; ?> >1915</option>	
									<option value="1916" <?php if ($dob_year == "1916") echo "selected=\"selected\""; ?> >1916</option>	
									<option value="1917" <?php if ($dob_year == "1917") echo "selected=\"selected\""; ?> >1917</option>	
									<option value="1918" <?php if ($dob_year == "1918") echo "selected=\"selected\""; ?> >1918</option>	
									<option value="1919" <?php if ($dob_year == "1919") echo "selected=\"selected\""; ?> >1919</option>	
									<option value="1920" <?php if ($dob_year == "1920") echo "selected=\"selected\""; ?> >1920</option>	
									<option value="1921" <?php if ($dob_year == "1921") echo "selected=\"selected\""; ?> >1921</option>	
									<option value="1922" <?php if ($dob_year == "1922") echo "selected=\"selected\""; ?> >1922</option>	
									<option value="1923" <?php if ($dob_year == "1923") echo "selected=\"selected\""; ?> >1923</option>	
									<option value="1924" <?php if ($dob_year == "1924") echo "selected=\"selected\""; ?> >1924</option>	
									<option value="1925" <?php if ($dob_year == "1925") echo "selected=\"selected\""; ?> >1925</option>	
									<option value="1926" <?php if ($dob_year == "1926") echo "selected=\"selected\""; ?> >1926</option>	
									<option value="1927" <?php if ($dob_year == "1927") echo "selected=\"selected\""; ?> >1927</option>	
									<option value="1928" <?php if ($dob_year == "1928") echo "selected=\"selected\""; ?> >1928</option>	
									<option value="1929" <?php if ($dob_year == "1929") echo "selected=\"selected\""; ?> >1929</option>	
									<option value="1930" <?php if ($dob_year == "1930") echo "selected=\"selected\""; ?> >1930</option>	
									<option value="1931" <?php if ($dob_year == "1931") echo "selected=\"selected\""; ?> >1931</option>	
									<option value="1932" <?php if ($dob_year == "1932") echo "selected=\"selected\""; ?> >1932</option>	
									<option value="1933" <?php if ($dob_year == "1933") echo "selected=\"selected\""; ?> >1933</option>	
									<option value="1934" <?php if ($dob_year == "1934") echo "selected=\"selected\""; ?> >1934</option>	
									<option value="1935" <?php if ($dob_year == "1935") echo "selected=\"selected\""; ?> >1935</option>	
									<option value="1936" <?php if ($dob_year == "1936") echo "selected=\"selected\""; ?> >1936</option>	
									<option value="1937" <?php if ($dob_year == "1937") echo "selected=\"selected\""; ?> >1937</option>	
									<option value="1938" <?php if ($dob_year == "1938") echo "selected=\"selected\""; ?> >1938</option>	
									<option value="1939" <?php if ($dob_year == "1939") echo "selected=\"selected\""; ?> >1939</option>	
									<option value="1940" <?php if ($dob_year == "1940") echo "selected=\"selected\""; ?> >1940</option>	
									<option value="1941" <?php if ($dob_year == "1941") echo "selected=\"selected\""; ?> >1941</option>	
									<option value="1942" <?php if ($dob_year == "1942") echo "selected=\"selected\""; ?> >1942</option>	
									<option value="1943" <?php if ($dob_year == "1943") echo "selected=\"selected\""; ?> >1943</option>	
									<option value="1944" <?php if ($dob_year == "1944") echo "selected=\"selected\""; ?> >1944</option>	
									<option value="1945" <?php if ($dob_year == "1945") echo "selected=\"selected\""; ?> >1945</option>	
									<option value="1946" <?php if ($dob_year == "1946") echo "selected=\"selected\""; ?> >1946</option>	
									<option value="1947" <?php if ($dob_year == "1947") echo "selected=\"selected\""; ?> >1947</option>	
									<option value="1948" <?php if ($dob_year == "1948") echo "selected=\"selected\""; ?> >1948</option>	
									<option value="1949" <?php if ($dob_year == "1949") echo "selected=\"selected\""; ?> >1949</option>	
									<option value="1950" <?php if ($dob_year == "1950") echo "selected=\"selected\""; ?> >1950</option>	
									<option value="1951" <?php if ($dob_year == "1951") echo "selected=\"selected\""; ?> >1951</option>	
									<option value="1952" <?php if ($dob_year == "1952") echo "selected=\"selected\""; ?> >1952</option>	
									<option value="1953" <?php if ($dob_year == "1953") echo "selected=\"selected\""; ?> >1953</option>	
									<option value="1954" <?php if ($dob_year == "1954") echo "selected=\"selected\""; ?> >1954</option>	
									<option value="1955" <?php if ($dob_year == "1955") echo "selected=\"selected\""; ?> >1955</option>	
									<option value="1956" <?php if ($dob_year == "1956") echo "selected=\"selected\""; ?> >1956</option>	
									<option value="1957" <?php if ($dob_year == "1957") echo "selected=\"selected\""; ?> >1957</option>	
									<option value="1958" <?php if ($dob_year == "1958") echo "selected=\"selected\""; ?> >1958</option>	
									<option value="1959" <?php if ($dob_year == "1959") echo "selected=\"selected\""; ?> >1959</option>	
									<option value="1960" <?php if ($dob_year == "1960") echo "selected=\"selected\""; ?> >1960</option>	
									<option value="1961" <?php if ($dob_year == "1961") echo "selected=\"selected\""; ?> >1961</option>	
									<option value="1962" <?php if ($dob_year == "1962") echo "selected=\"selected\""; ?> >1962</option>	
									<option value="1963" <?php if ($dob_year == "1963") echo "selected=\"selected\""; ?> >1963</option>	
									<option value="1964" <?php if ($dob_year == "1964") echo "selected=\"selected\""; ?> >1964</option>	
									<option value="1965" <?php if ($dob_year == "1965") echo "selected=\"selected\""; ?> >1965</option>	
									<option value="1966" <?php if ($dob_year == "1966") echo "selected=\"selected\""; ?> >1966</option>	
									<option value="1967" <?php if ($dob_year == "1967") echo "selected=\"selected\""; ?> >1967</option>	
									<option value="1968" <?php if ($dob_year == "1968") echo "selected=\"selected\""; ?> >1968</option>	
									<option value="1969" <?php if ($dob_year == "1969") echo "selected=\"selected\""; ?> >1969</option>	
									<option value="1970" <?php if ($dob_year == "1970") echo "selected=\"selected\""; ?> >1970</option>	
									<option value="1971" <?php if ($dob_year == "1971") echo "selected=\"selected\""; ?> >1971</option>	
									<option value="1972" <?php if ($dob_year == "1972") echo "selected=\"selected\""; ?> >1972</option>	
									<option value="1973" <?php if ($dob_year == "1973") echo "selected=\"selected\""; ?> >1973</option>	
									<option value="1974" <?php if ($dob_year == "1974") echo "selected=\"selected\""; ?> >1974</option>	
									<option value="1975" <?php if ($dob_year == "1975") echo "selected=\"selected\""; ?> >1975</option>	
									<option value="1976" <?php if ($dob_year == "1976") echo "selected=\"selected\""; ?> >1976</option>	
									<option value="1977" <?php if ($dob_year == "1977") echo "selected=\"selected\""; ?> >1977</option>	
									<option value="1978" <?php if ($dob_year == "1978") echo "selected=\"selected\""; ?> >1978</option>	
									<option value="1979" <?php if ($dob_year == "1979") echo "selected=\"selected\""; ?> >1979</option>	
									<option value="1980" <?php if ($dob_year == "1980") echo "selected=\"selected\""; ?> >1980</option>	
									<option value="1981" <?php if ($dob_year == "1981") echo "selected=\"selected\""; ?> >1981</option>	
									<option value="1982" <?php if ($dob_year == "1982") echo "selected=\"selected\""; ?> >1982</option>	
									<option value="1983" <?php if ($dob_year == "1983") echo "selected=\"selected\""; ?> >1983</option>	
									<option value="1984" <?php if ($dob_year == "1984") echo "selected=\"selected\""; ?> >1984</option>	
									<option value="1985" <?php if ($dob_year == "1985") echo "selected=\"selected\""; ?> >1985</option>	
									<option value="1986" <?php if ($dob_year == "1986") echo "selected=\"selected\""; ?> >1986</option>	
									<option value="1987" <?php if ($dob_year == "1987") echo "selected=\"selected\""; ?> >1987</option>	
									<option value="1988" <?php if ($dob_year == "1988") echo "selected=\"selected\""; ?> >1988</option>	
									<option value="1989" <?php if ($dob_year == "1989") echo "selected=\"selected\""; ?> >1989</option>	
									<option value="1990" <?php if ($dob_year == "1990") echo "selected=\"selected\""; ?> >1990</option>	
									<option value="1991" <?php if ($dob_year == "1991") echo "selected=\"selected\""; ?> >1991</option>	
									<option value="1992" <?php if ($dob_year == "1992") echo "selected=\"selected\""; ?> >1992</option>	
									<option value="1993" <?php if ($dob_year == "1993") echo "selected=\"selected\""; ?> >1993</option>	
									<option value="1994" <?php if ($dob_year == "1994") echo "selected=\"selected\""; ?> >1994</option>	
									<option value="1995" <?php if ($dob_year == "1995") echo "selected=\"selected\""; ?> >1995</option>	
									<option value="1996" <?php if ($dob_year == "1996") echo "selected=\"selected\""; ?> >1996</option>	
									<option value="1997" <?php if ($dob_year == "1997") echo "selected=\"selected\""; ?> >1997</option>	
									<option value="1998" <?php if ($dob_year == "1998") echo "selected=\"selected\""; ?> >1998</option>	
									<option value="1999" <?php if ($dob_year == "1999") echo "selected=\"selected\""; ?> >1999</option>	
									<option value="2000" <?php if ($dob_year == "2000") echo "selected=\"selected\""; ?> >2000</option>	
								</select>
								
								
									
							</div>
							
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><input type="checkbox" name="news" value="1" <?php if($News == 1) echo "CHECKED"; ?> /></div>
							<p>Receive Newsletter</p>
							<div class="cL"></div>	
						</div>
					</div>
					<div class="fL_names4">
						<div class="block">
							<div align="right" class="img"><img src="images/street.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="street" value="<?php echo $street; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/city.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="city" value="<?php echo $city; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/state.gif" alt="" border="0px" /></div>
							<div class="select">
								<select id="state" name="state"  class="select_4">
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
							
							</div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/zip.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="zip" value="<?php echo $zip;?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
						<div class="block">
							<div align="right" class="img"><img src="images/country.gif" alt="" border="0px" /></div>
							
							
								<select id="country" name="country"  class="select_4" onChange="Javascript: changecountry();">
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
						<div class="block">
							<div align="right" class="img"><img src="images/phone.gif" alt="" border="0px" /></div>
							<div class="input"><input  type="text"  name="phone" value="<?php echo $phone; ?>" class="form_ind4" /></div>
							<div class="cL"></div>	
						</div>
					</div>
					<div class="cL"></div>				
					<br>
					<!--<div class="line_7"></div>	
					<div class="facebook2"></div><div class="input2"><input  type="text"  name="FacebookLink" value="<?php echo $FacebookLink; ?>" class="form2_ind4" /></div>
					<div class="cL"></div>	
					<div class="twitter2"></div><div class="input2"><input  type="text"  name="TwitterLink" value="<?php echo $TwitterLink; ?>" class="form2_ind4" /></div>
					<div class="cL"></div>-->
					<input type="submit" value="" class="save" />
				</form>
			</div>
		</div>
		<div class="shadow10_bottom"><div class="bottom_6"></div></div>
	</div>	
			
<!-- CONTENT EOF   -->

<!-- BEGIN FOOTER -->	
	
	<?php include('footer.php'); ?>
	
<!-- FOOTER EOF   -->			

<!-- BODY EOF -->	
</div>
</body>
</html>
