<?php
	require_once('dbinfo.inc.php');
	require_once('api_functions.inc.php');

	if(check_if_login_session_valid() == false)
	{
		exit();
	}

	$x_customer = get_customer_id();

	header("Content-type: text/xml");
	$xml = "<?xml version=\"1.0\"?>\n";
	$xml .= "<account>\n";

	$query="ECLIPSE_GETACCOUNTINFO '$x_customer', '$db_apikey'";

	$result=mssql_query($query);
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

			$xml .= "\t<CustomerID>" . $member['CustomerID'] . "</CustomerID>\n";
			$xml .= "\t<gamertag>" . $gamertag . "</gamertag>\n";
			$xml .= "\t<gamepoints>" . $gamepoints . "</gamepoints>\n";
			$xml .= "\t<HonorPoints>" . $HonorPoints . "</HonorPoints>\n";
			$xml .= "\t<SkillPoints>" . $SkillPoints . "</SkillPoints>\n";
			$xml .= "\t<Kills>" . $Kills . "</Kills>\n";
			$xml .= "\t<Deaths>" . $Deaths . "</Deaths>\n";
			$xml .= "\t<ShotsFired>" . $ShotsFired . "</ShotsFired>\n";
			$xml .= "\t<ShotsHits>" . $ShotsHits . "</ShotsHits>\n";
			$xml .= "\t<Headshots>" . $Headshots . "</Headshots>\n";
			$xml .= "\t<AssistKills>" . $AssistKills . "</AssistKills>\n";
			$xml .= "\t<Wins>" . $Wins . "</Wins>\n";
			$xml .= "\t<Losses>" . $Losses . "</Losses>\n";
			$xml .= "\t<CaptureNeutralPoints>" . $CaptureNeutralPoints . "</CaptureNeutralPoints>\n";
			$xml .= "\t<CaptureEnemyPoints>" . $CaptureEnemyPoints . "</CaptureEnemyPoints>\n";
			$xml .= "\t<TimePlayed>" . $TimePlayed . "</TimePlayed>\n";

			$xml .= "\t<Skills>" . $Skills . "</Skills>\n";
			$xml .= "\t<Achievements>" . $Achievements . "</Achievements>\n";
			$xml .= "\t<Abilities>" . $Abilities . "</Abilities>\n";
			$xml .= "\t<NumSlots>" . $NumSlots . "</NumSlots>\n";
			$xml .= "\t<Slot1>" . $Slot1 . "</Slot1>\n";
			$xml .= "\t<Slot2>" . $Slot2 . "</Slot2>\n";
			$xml .= "\t<Slot3>" . $Slot3 . "</Slot3>\n";
			$xml .= "\t<Slot4>" . $Slot4 . "</Slot4>\n";
			$xml .= "\t<Slot5>" . $Slot5 . "</Slot5>\n";
			$xml .= "\t<Slot6>" . $Slot6 . "</Slot6>\n";
		}
	}

	$xml .= "</account>";

	echo $xml;
	
	mssql_close($con);
?>
