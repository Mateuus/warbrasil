<?php
	
?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />  
<title>Login test</title>
<link href="main.css" rel="stylesheet" type="text/css" />
</head>

<body>

          Login<br /><br />

<form id="usernameForm" name="usernameForm" method="post" action="api_login.php">

Username&nbsp;&nbsp; <input name="username" type="text" style="width: 175px" class="textfield" id="username" />        
<br>
Password&nbsp;&nbsp; <input name="password" type="password" style="width: 175px"  class="textfield" id="password" />         
<br><br>
<input type="submit" name="Login" width="73" height="24" />

        </form>

<br /><br />
          Get Profile<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_profile_get.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />
<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
<input type="submit" name="Get Profile" width="73" height="24" />

        </form>


<br /><br />
          Update Profile<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_profile_update.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />
<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
<br>
HonorP <input name="HonorPoints" type="text"/>
<br>
GameP <input name="GamePoints" type="text"/>
<br>
SkillP <input name="SkillPoints" type="text"/>


<br>
Kills <input name="Kills" type="text"/>
<br>
Deaths <input name="Deaths" type="text"/>
<br>
ShotsFired <input name="ShotsFired" type="text"/>
<br>
ShotsHits <input name="ShotsHits" type="text"/>

<br>
Headshots <input name="Headshots" type="text"/>
<br>
AssistKills <input name="AssistKills" type="text"/>
<br>
Wins <input name="Wins" type="text"/>
<br>
Losses <input name="Losses" type="text"/>

<br>
CaptureNeutralPoints <input name="CaptureNeutralPoints" type="text"/>
<br>
CaptureEnemyPoints <input name="CaptureEnemyPoints" type="text"/>

<br>
TimePlayed <input name="TimePlayed" type="text"/>


<br>
<input type="submit" name="Get Profile" width="73" height="24" />

        </form>





<br /><br />
          Unlock slot<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_unlockslot.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Profile" width="73" height="24" />
        </form>


<br /><br />
          LearnSkill<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_learnskill.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

Skill ID&nbsp; <input name="skillid" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Profile" width="73" height="24" />
        </form>


<br /><br />
          Get Item Mall<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getmall.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Itemlist" width="73" height="24" />
        </form>


<br /><br />
          Buy Item<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_buyitem.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

SKU ID&nbsp; <input name="skuid" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Inventory" width="73" height="24" />
        </form>


<br /><br />
          GeInventory<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getinventory.php">

User ID&nbsp; <input name="sessiontoken" type="text" style="width: 175px" class="textfield" id="sessiontoken" />

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Inventory" width="73" height="24" />
        </form>

<br /><br />
          Get All Items<br /><br />

<form id="GetProfile" name="GetProfile" method="post" action="api_getitemsdb.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" name="Get Items" width="73" height="24" />
        </form>


		
</body>
</html>
