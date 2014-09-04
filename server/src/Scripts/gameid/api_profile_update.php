<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	

	$api_key = $db_apikey;
	$server_key =$_POST['serverkey'];	

	if ($server_key != 'nRkO2RbhIEvvA6c7Lp54qkY0cLd2') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


		$GamePoints=$_POST['GamePoints'];
		$HonorPoints=$_POST['HonorPoints'];
		$SkillPoints=$_POST['SkillPoints'];
		$Kills=$_POST['Kills'];
		$Deaths=$_POST['Deaths'];
		$ShotsFired=$_POST['ShotsFired'];
		$ShotsHits=$_POST['ShotsHits'];
		$Headshots=$_POST['Headshots'];
		$AssistKills=$_POST['AssistKills'];
		$Wins=$_POST['Wins'];
		$Losses=$_POST['Losses'];
		$CaptureNeutralPoints=$_POST['CaptureNeutralPoints'];
		$CaptureEnemyPoints=$_POST['CaptureEnemyPoints'];
		$TimePlayed=$_POST['TimePlayed'];

	$query="ECLIPSE_UPDATESTATS '$x_customer', '$api_key', '$GamePoints','$HonorPoints','$SkillPoints',
	'$Kills','$Deaths','$ShotsFired','$ShotsHits','$Headshots', '$AssistKills',
	'$Wins','$Losses','$CaptureNeutralPoints','$CaptureEnemyPoints','$TimePlayed'";

	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
//		if(mssql_num_rows($result)>0)
//		{
			//username Successful
//			$member=mssql_fetch_assoc($result);
			exit();
//		}else 
//			{
//				echo "XXX GETPROFILE FAILED\n";
//				exit();
//			}
	}else {
//				echo "XXX GETPROFILE FAILED\n";
				exit();
	}
	
	mssql_close($con);

?>