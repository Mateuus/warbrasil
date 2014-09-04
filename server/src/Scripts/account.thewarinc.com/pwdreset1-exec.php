<?php
	$email = $_POST['email'];
	if(!isset($email) || strlen($email)<4) {
		header("location: pwdreset1.php?id=3");
		exit();
	}
	
	require_once('dbinfo.inc.php');

	$Last_IP = $_SERVER['REMOTE_ADDR']; 

	// create & execute query
	$tsql   = "EXEC ECLIPSE_PwdResetRequest ?,?";
	$params = array($Last_IP, $email);
	$member = db_exec($conn, $tsql, $params);

	$rc=$member['ResultCode'];	
	if(!isset($rc) || $rc != 0)
	{
		header("location: pwdreset1.php?id=3");
		exit();
	}

	$token = $member['token'];
	if(!isset($token))
	{
		die('no token');
	}
	$url = "https://account.thewarinc.com/pwdreset2.php?token=$token";

	$body  = "Someone from $Last_IP requested password reset to War Inc. Battlezone\n";
	$body .= "If it wasn't you please disregard this message\n";
	$body .= "\n";
	$body .= "Otherwise please visit the following link $url to set your new password\n";

	$subject = "Your password reset link to War Inc. Battlezone";

	if(send_pwdreset_email($email, $body, $subject)) {
		header("location: pwdreset1.php?id=1");
		exit();
	} else {
		header("location: pwdreset1.phpid=2");
		exit();
	}

function send_pwdreset_email($email, $body, $subject)
{
	require_once('PHPMailer_v5.1/class.phpmailer.php');

	$mail = new PHPMailer(true); // the true param means it will throw exceptions on errors, which we need to catch

	try {
		$mail->IsSMTP(); // telling the class to use SMTP
		$mail->SMTPDebug  = 1;
		$mail->SMTPAuth   = true;
		$mail->Host       = "smtp.1and1.com";
		$mail->Username   = "support@thewarinc.com";
		$mail->Password   = "Wsxmko!10";

		$mail->SetFrom('support@thewarinc.com', 'Arktos Entertainment Group');
		$mail->Subject    = $subject;
		$mail->Body       = $body;
		$mail->AddAddress($email, $email);

		$mail->Send();

		return true;
	} 
	catch (phpmailerException $e) 
	{
		return false;
	}
	catch (Exception $e)
	{
		return false;
	}
}

?>