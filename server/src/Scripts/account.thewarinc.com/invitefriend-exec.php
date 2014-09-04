<?php
	session_start();
	require_once('auth.php'); 

	$inv_from   = $_SESSION['CustomerEmail'];
	if(!isset($inv_from) || strlen($inv_from) < 3)
		die('inv_from');

	$inv_userid = $_POST['inv_userid'];
	$inv_resend = $_POST['inv_resend'];
	$inv_email  = $_POST['inv_email'];
	$inv_code   = $_POST['inv_code'];

	if(!isset($inv_email) || strlen($inv_email) < 3)
	{
		header("Location: /inviteForm.php");
		exit();
	}

	if($inv_resend == 1)
	{
		send_invite($inv_email, $inv_code, $inv_from);
		exit();
	}


	// get actual invite code from DB

	require_once('dbinfo.inc.php');
	// create & execute query
	$tsql   = "EXECUTE ECLIPSE_UserInviteGetInvite ?, ?";
	$params = array($inv_userid, $inv_email);
	$member = db_exec($conn, $tsql, $params);

	$rc = $member['ResultCode'];
	$ic = $member['InviteCode'];

	if($rc == 0)
	{
		// no error
		send_invite($inv_email, $ic, $inv_from);
		exit();
	}

	switch($rc)
	{
		case 1:
			echo "You don't have any more invites";
			break;
		case 2:
			echo "Email $inv_email already registered";
			break;
		case 3:
			echo "We run out of invites, please try again later.";
			break;
		default:
			echo "Unknown error.";
			break;
	}
	exit();

	//
	// actual send function
	//

	function send_invite($email, $invcode, $inviter)
	{
		require_once('PHPMailer_v5.1/class.phpmailer.php');

		if(!isset($email))
			die('email');
		if(!isset($invcode))
			die('invcode');


		$body             = file_get_contents("EMails\email_invite.html");
		$body             = ereg_replace("-SERIALCODE-", $invcode, $body);

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

		$mail->SetFrom($inviter); //'donotreply@thewarinc.com', 'Arktos Entertainment Group');
		$mail->Subject    = "Welcome to War Inc Battlezone Closed Beta Test!";
		$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!";
		$mail->MsgHTML($body);
		$mail->AddAddress($email);

		$mail->Send();

		// sent ok, redirect back
		header("Location: /inviteForm.php");

		} catch (phpmailerException $e) {
			echo "<strong>There was error sending mail to $email</strong>";
			echo $e->errorMessage(); // Pretty error messages from PHPMailer
		} catch (Exception $e) {
			echo "<strong>There was error sending mail to $email</strong>";
			echo $e->getMessage(); // Boring error messages from anything else!
		}
	}
?>