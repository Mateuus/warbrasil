<?php

require_once('phpmailer4/class.phpmailer.php');
//include("class.smtp.php"); // optional, gets called from within class.phpmailer.php if not already loaded

function file_get_contents_curl($url) {
	$ch = curl_init();
	
	curl_setopt($ch, CURLOPT_HEADER, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //Set curl to return the data instead of printing it to the browser.
	curl_setopt($ch, CURLOPT_URL, $url);
	
	$data = curl_exec($ch);
	curl_close($ch);
	
	return $data;
}


	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_emails=$_POST['emails'];	
	$server_key =$_POST['serverkey'];	
	$mtext = $_POST['mtext'];

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}

	$api_key = $db_apikey;

	$array = explode("\r",$mtext);

	// count how many emails there are.
	$total_emails = count($array);
	echo 'Total EMails = ' . $total_emails . '<br>';
	for ( $counter = 0; $counter < $total_emails; $counter += 1)
        {
	 echo 'Sending ->' . $array[$counter] . '<br>';
	 $x_email = $array[$counter];

	 $query="SENDINVITE '$x_email','$api_key'";
	 $result=mssql_query($query);

	 if($result) 
	 {
	 	if(mssql_num_rows($result)>0)
		{
			//username Successful
			$member=mssql_fetch_assoc($result);

			 $Result=$member['Result'];
        		 echo "Result is $Result<br>";
			
			 if ($Result != 'BAD CODE')
			 {

				$mail             = new PHPMailer();

//				$body             = file_get_contents("email_invite.html");
				$body             = file_get_contents_curl("http://gameid.arktosentertainment.com/email_invite.html");
				$body             = ereg_replace("-SERIALCODE-",$Result,$body);

				$mail->IsSMTP(); // telling the class to use SMTP
				$mail->Host       = "mail.cdnthewarinc.net"; // SMTP server
				$mail->SMTPDebug  = 1;  // enables SMTP debug information (for testing)
                                           // 1 = errors and messages
                                           // 2 = messages only
				$mail->SMTPAuth   = true;                  // enable SMTP authentication
				$mail->Port       = 26;                    // set the SMTP port for the GMAIL server
				$mail->Username   = "champion@cdnthewarinc.net"; // SMTP account username
				$mail->Password   = "wsxmko!10";        // SMTP account password

				$mail->From       = "donotreply@thewarinc.com";
				$mail->FromName   = "Arktos Entertainment Group";
				$mail->Subject    = "Welcome to War Inc Battlezone Closed Alpha Test !";
				$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; //Text Body

				$mail->MsgHTML($body);

				$mail->AddAddress($x_email, "Valued Tester");

				//$mail->AddAttachment("222");      // attachment

				if(!$mail->Send()) {
					  echo "<strong>Mailer Error: " . $mail->ErrorInfo ."</strong><br>";
				} else {
					  echo "Message sent!<br>";
				}
			    
                          }			 

		}else 
			{
				echo "Wrong result \n";
			}
	  }else {
				echo "Wrong Result\n";
		}

        } // for all emails loop
	exit();
	
	mssql_close($con);

?>
