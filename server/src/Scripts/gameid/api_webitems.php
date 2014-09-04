<?php
	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	if ($Last_IP != '173.196.5.194')
        {
		if ($Last_IP != '67.160.192.72')
        	{

		echo "IP lockout !"; 
		exit();
		}
        }


	
?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />  
<title>Add Item</title>
<link href="main.css" rel="stylesheet" type="text/css" />
</head>

<body>


Get All Weapons<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getWeaponDB.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Items" width="73" height="24" />
        </form>

Get All Gear Items<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getGearDB.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Items" width="73" height="24" />
        </form>


Get Item Mall<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getmall.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Itemlist" width="73" height="24" />
        </form>



Add Gear Item<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_addgear.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
<br>
Categories :<br>
storecat_Characters = 10<br>
storecat_Gear	    = 11<br>
storecat_Heads	    = 12<br>
storecat_HeadGear   = 13<br>
storecat_Camo	    = 14<br>
storecat_Voice	    = 15<br>
Category <input name="cat" type="text"/><br>
FNAME is unique file name identiofier. This ised as prefix for SCO files, DDS icons, etc<br>
FNAME <input name="fname" type="text"/><br>
Item Name <input name="name" type="text"/><br>
Description <input name="desc" type="text" width="400" height="100"/><br>
Weight [0..100]<input name="weight" type="text"/><br>
How much Damage in % consumed by armor<br>
DamagePerc [0..100]<input name="damageperc" type="text"/><br>
Maximum amount of damage consumed cumulatively by armor<br>
DamageMax [0..500]<input name="damagemax" type="text"/><br>
Bulkiness [0..100]<input name="bulk" type="text"/><br>
Inaccuracy [0..100]<input name="acc" type="text"/><br>
Stealth [0..100]<input name="stealth" type="text"/><br>
<br>
Item Mall parameters ( if price is 0 then SKU won't be created )<br>
1 Day Price<input name="cost1" type="text"/><br>
3 Day Price<input name="cost3" type="text"/><br>
7 Day Price<input name="cost7" type="text"/><br>
30 Day Price<input name="cost30" type="text"/><br>
60 Day Price<input name="cost60" type="text"/><br>
90 Day Price<input name="cost90" type="text"/><br>
Perm Price<input name="costperm" type="text"/><br>
<br>
<br>
<input type="submit" name="Create Gear Item" width="73" height="24" />

        </form>


		
</body>
</html>
