<?php
	require_once('iplock.inc.php');
	require_once('curl.inc.php');
	require_once('dbinfo.inc.php');

	set_time_limit(0);

	$server_key = $_POST['serverkey'];
	if($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}

	$email_url = "http://account.thewarinc.com/emails/email_invite.html";
	echo "Fetching invite letter from $email_url<br>";
	$org_body = file_get_contents_curl($email_url);
	if(!strstr($org_body, "-SERIALCODE-"))
	{
		echo "there is no -SERIALCODE- in $email_url";
		exit();
	}

	// get email array
	$mtext      = $_POST['mtext'];
	$arr_emails = explode("\r", $mtext);
	$total_emails = count($arr_emails);
	echo "Total EMails = $total_emails <br>";

	for($counter = 0; $counter < $total_emails; $counter ++)
	{
		$email = $arr_emails[$counter];
		echo "[$counter/$total_emails] -> $email, ";

		// create & execute query
		$tsql   = "EXEC ECLIPSE_SENDINVITE ?";
		$params = array($email);
		$member = db_exec($conn, $tsql, $params);
		
		$ResultCode = $member['ResultCode'];
		$InviteCode = $member['InviteCode'];
		if($ResultCode != 0)
		{
			echo "FAILED! $InviteCode<br>";
			exit();
		}

		echo " - $InviteCode - ";

		$body = ereg_replace("-SERIALCODE-", $InviteCode, $org_body);
		send_invite_email($email, $body);
		echo "<br>";

        } // for all emails loop

	exit();

	//
	// actual send function
	//

	function send_invite_email($email, $body)
	{
		require_once('PHPMailer_v5.1/class.phpmailer.php');

		$mail             = new PHPMailer(true); // the true param means it will throw exceptions on errors, which we need to catch

		try {
		$mail->IsSMTP(); // telling the class to use SMTP
		$mail->SMTPDebug  = 1;  // enables SMTP debug information (for testing)
					// 1 = errors and messages
					// 2 = messages only
		$mail->SMTPAuth   = true;
		$mail->Host       = "smtp.sendgrid.net";
		$mail->Username   = "pr@arktosentertainment.com";
		$mail->Password   = "wsxmko!10";

		$mail->SetFrom("donotreply@thewarinc.com", "War Inc. Battlezone");
		$mail->Subject    = "Welcome to War Inc Battlezone Closed Beta Test!";
		$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!";
		$mail->MsgHTML($body);
		$mail->AddAddress($email, $email);

		$mail->Send();
		echo "sent";

		} catch (phpmailerException $e) {
			echo "<strong>There was error sending mail to $email - </strong>";
			echo $e->errorMessage(); // Pretty error messages from PHPMailer
		} catch (Exception $e) {
			echo "<strong>There was error sending mail to $email - </strong>";
			echo $e->getMessage(); // Boring error messages from anything else!
		}
	}
?>