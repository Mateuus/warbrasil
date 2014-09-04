<?php
	require_once('iplock.inc.php');
	require_once('curl.inc.php');

	set_time_limit(0);

	$server_key = $_POST['serverkey'];
	if($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}

	require_once('dbinfo.inc.php');
	
	// read newsletter
	$news_url = $_POST['newsurl'];
	echo "Fetching newsletter from $news_url<br>";
	$org_body = file_get_contents_curl($news_url);

	$testsend = $_POST['testsend'];
	if($testsend > 0)
	{
		echo "<br>sending 1 - ";
		send_news_email('sergey.titov@arktosentertainment.com', $org_body);
		echo "<br>sending 2 - ";
		send_news_email('denis.zhulitov@arktosentertainment.com', $org_body);
		echo "done<br>";
		exit();
	}

	// create & execute query
	$tsql   = "SELECT COUNT(*) FROM AccountInfo";
	$params = array();
	$member = db_exec($conn, $tsql, $params);

	$num_users = $member[""];
	$cur_user  = 0;

	// create & execute query
	$tsql   = "SELECT email,CustomerID FROM AccountInfo";
	$params = array();
	$stmt   = sqlsrv_query($conn, $tsql, $params);

	while($member = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC))
	{
		$CustomerID = $member['CustomerID'];
		$email      = $member['email'];

		echo "[$cur_user/$num_users] - $CustomerID ($email) - ";
		$cur_user++;

		send_news_email($email, $org_body);
		echo "<br>";
	}
	exit();

	function send_news_email($email, $body)
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
		$mail->Subject    = "War Inc Battlezone Newsletter";
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