<?php
	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	if ($Last_IP != '173.196.5.194')
        {
		if ($Last_IP != '75.84.253.195')
        	{

		echo "IP lockout !"; 
		exit();
		}
        }
	
?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />  
<title>Send Invites</title>
</head>

<body>

<br>
Send Invites><br<br>

<form id="GetProfile" name="GetProfile" method="post" action="api_SendInviteExecute.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<textarea name="mtext" cols="50" rows="20"></textarea>

<input type="submit" name="Send Invites" width="73" height="24" />
        </form>

<br><br><br><br>
<br>
Send Newsletter<br<br>

<form id="GetProfile" name="GetProfile" method="post" action="api_sendNewsletter.php">

<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />

<input type="submit" value="Send Newsletter" width="73" height="24" />
        </form>


		
</body>
</html>
