<?php
	require_once('iplock.inc.php');
?>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />  
<title>Arktos Intranet</title>
</head>

<body>

<br><strong>Send Invites</strong><br>

<form id="sendinv" name="sendinv" method="post" action="api_SendInviteExecute.php">
	<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
	<textarea name="mtext" cols="50" rows="20"></textarea>
	<input type="submit" value="Send Invites" width="73" height="24" />
</form>

<br><br><br>
<br><strong>Send *TEST* Newsletter</strong><br>

<form id="sendnews" name="sendnews" method="post" action="api_sendNewsletter.php">
	<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
	<input type="hidden" name="testsend" value="1" />
	Newsletter URL: <input type="label" name="newsurl" value="" width="300"/>
	<br><input type="submit" value="Send Newsletter" width="73" height="24" />
</form>

<br><br><br>
<br><strong>Send Newsletter to ALL USERS</strong><br>

<form id="sendnews" name="sendnews" method="post" action="api_sendNewsletter.php">
	<input type="hidden" name="serverkey" value="CfFkqQWjfgksYG56893GDhjfjZ20" />
	<input type="hidden" name="testsend" value="0" />
	Newsletter URL: <input type="label" name="newsurl" value="" width="300"/>
	<br><input type="submit" value="Send Newsletter" width="73" height="24" />
</form>

</body>
</html>
