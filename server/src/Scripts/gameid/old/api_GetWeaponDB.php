<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\" ?>\n"; 
$xml_output .= "<WeaponsArmory>\n"; 


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
		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
        	{ 
			$member=mssql_fetch_assoc($result);

			$itemid=$member['ItemID'];
			$fname=str_replace (" ", "",$member['FNAME']);
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];

			$muzzlepart=$member['MuzzleParticle'];

			$anim=$member['Animation'];
			$sound1=$member['Sound_Shot'];
			$sound2=$member['Sound_Reload'];

			$BulletID=$member['BulletID'];
			$Damage=$member['Damage'];
			$isImmediate="true";
			if ($member['isImmediate'] == 0) $isImmediate="false";
			$Mass=$member['Mass'];
			$Speed=$member['Speed'];
			$DamageDecay=$member['DamageDecay'];
			$Area=$member['Area'];
			$Delay=$member['Delay'];
			$Timeout=$member['Timeout'];
			$NumClips=$member['NumClips'];
			$Clipsize=$member['Clipsize'];
			$ReloadTime=$member['ReloadTime'];
			$ActiveReloadTick=$member['ActiveReloadTick'];
			$RateOfFire=$member['RateOfFire'];
			$Spread=$member['Spread'];
			$Recoil=$member['Recoil'];

			$GR1=$member['NumGrenades'];
			$GR2=$member['GrenadeName'];


			$FM=$member['Firemode'];

			list($xx, $yy, $zz) = sscanf($member['MuzzleOffset'], "%f %f %f");

		    	$xml_output .= "\t<Weapon itemID=\"" . $itemid . "\" category=\"" . $cat . "\"  >\n "; 

		    	$xml_output .= "\t<Model file=\"Data/ObjectsDepot/Weapons/" . $fname . ".sco\" muzzlerOffset.x=\"".$xx."\" muzzlerOffset.y=\"".$yy."\" muzzlerOffset.z=\"".$zz."\"/>\n";

			$xml_output .= "\t<MuzzleModel file=\"". $muzzlepart . "\" />\n";

    			$xml_output .= "\t<HudIcon file=\"\$Data/Weapons/HudIcons/" . $fname . ".dds\"/> \n";

    			$xml_output .= "\t<Store name=\"" . $name . "\" icon=\"\$Data/Weapons/StoreIcons/" . $fname . ".dds\" desc=\"".$desc."\"/>\n";

    			$xml_output .= "\t<PrimaryFire bullet=\"".$BulletID."\" damage=\"".$Damage."\" immediate=\"".$isImmediate."\" mass=\"".$Mass."\" speed=\"".$Speed."\" area=\"".$Area."\" delay=\"".$Delay."\" timeout=\"".$Timeout."\" numShells=\"".$NumClips."\" clipSize=\"".$Clipsize."\" reloadTime=\"".$ReloadTime."\" activeReloadTick=\"".$ActiveReloadTick."\" rateOfFire=\"".$RateOfFire."\" spread=\"".$Spread."\" recoil=\"".$Recoil."\" numgrenades=\"".$GR1."\" grenadename=\"".$GR2."\" firemode=\"".$FM."\"  />\n";

    			$xml_output .= "\t<Animation type=\"" .$anim."\"/>\n";
    			$xml_output .= "\t<Sound shoot=\"" .$sound1."\" reload=\"".$sound2."\"/>\n";


		  	$xml_output .= "\t</Weapon>\n"; 
		}               


		$xml_output .= "</WeaponsArmory>\n\n"; 

		echo  $xml_output; 
		exit();


	}


	$xml_output .= "</WeaponsArmory>\n\n"; 
	echo $xml_output; 
	exit();
	
	mssql_close($con);

?>