<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\"?>\n"; 
$xml_output .= "<account>\n"; 


	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	


	$server_key =$_POST['serverkey'];	

	if ($server_key != "CfFkqQWjfgksYG56893GDhjfjZ20") 
	{
		echo "$server_key   ";
		echo "WRONG SERVER KEY";
		exit();
	}


	$api_key = $db_apikey;

	$query="ECLIPSE_GETACCOUNTINFO '$x_customer', '$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		if(mssql_num_rows($result)>0)
		{
			//username Successful
			$member=mssql_fetch_assoc($result);
        
			$gamertag=str_replace (" ", "",$member['Gamertag']);
			$gamepoints=$member['GamePoints'];
			$HonorPoints=$member['HonorPoints'];
			$SkillPoints=$member['SkillPoints'];

			$Kills=$member['Kills'];
			$Deaths=$member['Deaths'];
			$ShotsFired=$member['ShotsFired'];
			$ShotsHits =$member['ShotsHits'];
			$Headshots=$member['Headshots'];
			$AssistKills=$member['AssistKills'];
			$Wins=$member['Wins'];
			$Losses=$member['Losses'];
			$CaptureNeutralPoints=$member['CaptureNeutralPoints'];
			$CaptureEnemyPoints=$member['CaptureEnemyPoints'];
			$TimePlayed=$member['TimePlayed'];

			$Skills=$member['Skills'];
			$Achievements=$member['Achievements'];
			$Abilities=$member['Abilities'];

			$NumSlots=$member['LoadoutSlots'];
			$Slot1=$member['Loadout1'];
			$Slot2=$member['Loadout2'];
			$Slot3=$member['Loadout3'];
			$Slot4=$member['Loadout4'];
			$Slot5=$member['Loadout5'];
			$Slot6=$member['Loadout6'];

//			echo "$gamertag $gamepoints $HonorPoints $SkillPoints $Kills $Deaths $ShotsFired $ShotsHits $Headshots $AssistKills $Wins $Losses $CaptureNeutralPoints $CaptureEnemyPoints $TimePlayed ";
//			echo "\n$Skills\n$Achievements\n$Abilities";
//			echo "\n$NumSlots\n$Slot1\n$Slot2\n$Slot3\n$Slot4\n$Slot5\n$Slot6\n";
//			echo "<PROFILE END><br>";

			$xml_output .= "\t<CustomerID>" . $member['CustomerID'] . "</CustomerID>\n"; 
			$xml_output .= "\t<gamertag>" . $gamertag . "</gamertag>\n"; 
			$xml_output .= "\t<gamepoints>" . $gamepoints . "</gamepoints>\n"; 
			$xml_output .= "\t<HonorPoints>" . $HonorPoints . "</HonorPoints>\n"; 
			$xml_output .= "\t<SkillPoints>" . $SkillPoints . "</SkillPoints>\n"; 
			$xml_output .= "\t<Kills>" . $Kills . "</Kills>\n"; 
			$xml_output .= "\t<Deaths>" . $Deaths . "</Deaths>\n"; 
			$xml_output .= "\t<ShotsFired>" . $ShotsFired . "</ShotsFired>\n"; 
			$xml_output .= "\t<ShotsHits>" . $ShotsHits . "</ShotsHits>\n"; 
			$xml_output .= "\t<Headshots>" . $Headshots . "</Headshots>\n"; 
			$xml_output .= "\t<AssistKills>" . $AssistKills . "</AssistKills>\n"; 
			$xml_output .= "\t<Wins>" . $Wins . "</Wins>\n"; 
			$xml_output .= "\t<Losses>" . $Losses . "</Losses>\n"; 
			$xml_output .= "\t<CaptureNeutralPoints>" . $CaptureNeutralPoints . "</CaptureNeutralPoints>\n"; 
			$xml_output .= "\t<CaptureEnemyPoints>" . $CaptureEnemyPoints . "</CaptureEnemyPoints>\n"; 
			$xml_output .= "\t<TimePlayed>" . $TimePlayed . "</TimePlayed>\n"; 

			$xml_output .= "\t<Skills>" . $Skills . "</Skills>\n"; 
			$xml_output .= "\t<Achievements>" . $Achievements . "</Achievements>\n"; 
			$xml_output .= "\t<Abilities>" . $Abilities . "</Abilities>\n"; 
			$xml_output .= "\t<NumSlots>" . $NumSlots . "</NumSlots>\n"; 
			$xml_output .= "\t<Slot1>" . $Slot1 . "</Slot1>\n"; 
			$xml_output .= "\t<Slot2>" . $Slot2 . "</Slot2>\n"; 
			$xml_output .= "\t<Slot3>" . $Slot3 . "</Slot3>\n"; 
			$xml_output .= "\t<Slot4>" . $Slot4 . "</Slot4>\n"; 
			$xml_output .= "\t<Slot5>" . $Slot5 . "</Slot5>\n"; 
			$xml_output .= "\t<Slot6>" . $Slot6 . "</Slot6>\n"; 

			$xml_output .= "</account>"; 
			echo $xml_output; 
			exit();
		}
	}

	$xml_output .= "</entries>"; 
	echo $xml_output; 
	exit();
	
	mssql_close($con);

?>