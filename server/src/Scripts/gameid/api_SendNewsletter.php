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


	 $query="SELECT email,CustomerID FROM  AccountInfo where CustomerID between 1288037643 and 2288037624";
//	 $query="SELECT email,CustomerID FROM  AccountInfo";
	 $result=mssql_query($query);

	  echo mssql_num_rows($result) . '<br>';

	 if($result) 
	 {
		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
        	{ 
			//username Successful
			$member=mssql_fetch_assoc($result);

			 $xemail=$member['email'];
			 $id=$member['CustomerID'];
//	 		 echo $x . '-  ' . $id . '<br>  Sending ->' . $xemail ;
	 		 echo  $id . ' ';
			
			$mail             = new PHPMailer();

				$body             = file_get_contents_curl("http://gameid.arktosentertainment.com/Mail/Dec10.html");
//				$body             = ereg_replace("-SERIALCODE-",$Result,$body);

				$mail->IsSMTP(); // telling the class to use SMTP
				$mail->Host       = "smtp.sendgrid.net"; // SMTP server
				$mail->SMTPDebug  = 1;  // enables SMTP debug information (for testing)
                                           // 1 = errors and messages
                                           // 2 = messages only
				$mail->SMTPAuth   = true;                  // enable SMTP authentication
				$mail->Port       = 25;                    // set the SMTP port for the GMAIL server
				$mail->Username   = "pr@arktosentertainment.com"; // SMTP account username
				$mail->Password   = "wsxmko!10";        // SMTP account password

				$mail->From       = "donotreply@thewarinc.com";
				$mail->FromName   = "Arktos Entertainment Group";
				$mail->Subject    = "War Inc Battlezone Newsletter";
				$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; //Text Body

				$mail->MsgHTML($body);

				$mail->AddAddress($xemail, "Valued Tester");
//				$mail->AddAddress('sergey.titov@arktosentertainment.com', "Valued Tester");

				//$mail->AddAttachment("222");      // attachment

				if(!$mail->Send()) {
					  echo "<strong>Mailer Error: " . $mail->ErrorInfo ."</strong><br>";
				} else {
					  echo "... sent!<br>";
				}
			    
                    }			 

	  }else {
				echo "Wrong Result\n";
		}

	exit();
	
	mssql_close($con);

?>
