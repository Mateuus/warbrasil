<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\" ?>\n"; 
$xml_output .= "<AmmoArmory>\n"; 


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

	$query="ECLIPSE_GETALLITEMS1 '$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		mssql_next_result($result);

		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
        	{ 
			$member=mssql_fetch_assoc($result);

			$itemid=$member['ItemID'];
			$fname=str_replace (" ", "",$member['FNAME']);
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];

/*
Weight
DamagePerc
DamageMax
Bulkiness
Inaccuracy
Stealth
CustomFunction
Protection
*/
		    	$xml_output .= "\t<Gear itemID=\"" . $itemid . "\" category=\"" . $cat . "\"  >\n "; 

		    	$xml_output .= "\t<Model file=\"Data/ObjectsDepot/Characters/" . $fname . ".sco\" />\n";
    			$xml_output .= "\t<Store name=\"" . $name . "\" icon=\"\$Data/Weapons/StoreIcons/" . $fname . ".dds\" desc=\"".$desc."\"/>\n";

    			$xml_output .= "\t<Armor weight=\"10\" damagePerc=\"10\" damageMax=\"100\" bulkiness=\"0\" inaccuracy=\"0\" stealth=\"0\"/>\n";

		  	$xml_output .= "\t</Gear>\n"; 
		}               

		$xml_output .= "</AmmoArmory>\n\n"; 

		echo  $xml_output; 
		exit();


	}


	$xml_output .= "</AmmoArmory>\n\n"; 
	echo $xml_output; 
	exit();
	
	mssql_close($con);

?>