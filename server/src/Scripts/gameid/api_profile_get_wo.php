<?php
	require_once('dbinfo.inc.php');
	require_once('api_wo_functions.inc.php');

	wo_check_session();

	$LastIP     = $_SERVER['REMOTE_ADDR'];
	$CustomerID = wo_get_CustomerID();

	$query  = "EXECUTE WO_GETACCOUNTINFO '$LastIP', '$CustomerID'";
	$result = wo_mssql_exec($query);
	$member = mssql_fetch_assoc($result);

  // generate XML
	header("Content-type: text/xml"); 
	$xml = "<?xml version=\"1.0\"?>\n"; 
	$xml .= "<account ";
	$xml .= xml_attr("CustomerID",   $member['CustomerID']);
	$xml .= xml_attr("gamertag",     rtrim($member['Gamertag']));
	$xml .= xml_attr("gamepoints",   $member['GamePoints']);
	$xml .= xml_attr("HonorPoints",  $member['HonorPoints']);
	$xml .= xml_attr("SkillPoints",  $member['SkillPoints']);
	$xml .= xml_attr("Kills",        $member['Kills']);
	$xml .= xml_attr("Deaths",       $member['Deaths']);
	$xml .= xml_attr("ShotsFired",   $member['ShotsFired']);
	$xml .= xml_attr("ShotsHits",    $member['ShotsHits']);
	$xml .= xml_attr("Headshots",    $member['Headshots']);
	$xml .= xml_attr("AssistKills",  $member['AssistKills']);
	$xml .= xml_attr("Wins",         $member['Wins']);
	$xml .= xml_attr("Losses",       $member['Losses']);
	$xml .= xml_attr("CaptureNeutralPoints",  $member['CaptureNeutralPoints']);
	$xml .= xml_attr("CaptureEnemyPoints",    $member['CaptureEnemyPoints']);
	$xml .= xml_attr("TimePlayed",   $member['TimePlayed']);
	$xml .= xml_attr("Skills",       $member['Skills']);
	$xml .= xml_attr("Achievements", $member['Achievements']);
	$xml .= xml_attr("Abilities",    $member['Abilities']);
	$xml .= xml_attr("NumSlots",     $member['LoadoutSlots']);
	$xml .= xml_attr("Slot1",        $member['Loadout1']);
	$xml .= xml_attr("Slot2",        $member['Loadout2']);
	$xml .= xml_attr("Slot3",        $member['Loadout3']);
	$xml .= xml_attr("Slot4",        $member['Loadout4']);
	$xml .= xml_attr("Slot5",        $member['Loadout5']);
	$xml .= xml_attr("Slot6",        $member['Loadout6']);
	$xml .= ">";

 // now get inventory
	// move to next select, where data should be
	mssql_next_result($result);

	$xml .= "<inventory>\n";

	for($x = 0; $x < mssql_num_rows($result); $x++)
	{ 
		$member = mssql_fetch_assoc($result);
		if($member == false)
			break;

    		$xml .= "<i ";
		$xml .= xml_attr("id", $member['ItemID']);
		$xml .= xml_attr("ml", $member['MinutesLeft']);
		$xml .= "/>";
	}               

	$xml .= "</inventory>"; 
	$xml .= "</account>";

	echo $xml;
	
	mssql_close($con);
?>
