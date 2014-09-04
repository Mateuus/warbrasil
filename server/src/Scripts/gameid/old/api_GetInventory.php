<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\"?>\n"; 
$xml_output .= "<inventory>\n"; 


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

	$query="ECLIPSE_GETINVENTORY '$x_customer','$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
		{ 
			$member=mssql_fetch_assoc($result);

		    	$xml_output .= "\t<item>\n"; 

			$itemid=$member['ItemID'];
			$Expiration=$member['LeasedUntil'];
			$ExpirationS=$member['SecondsLeft'];
                       
			$fname=str_replace (" ", "",$member['FNAME']);
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];

			$xml_output .= "\t<ItemID>" . $itemid . "</ItemID>\n"; 
		 	$xml_output .= "\t<Expiration>" . $ExpirationS . "</Expiration>\n"; 

			$xml_output .= "\t<Category>" . $cat . "</Category>\n"; 
			$xml_output .= "\t<FNAME>" . $fname . "</FNAME>\n"; 
			$xml_output .= "\t<Name>" . $name . "</Name>\n"; 
			$xml_output .= "\t<Description>" . $desc . "</Description>\n"; 

		  	$xml_output .= "\t</item>\n"; 
		}               

		mssql_next_result ($result);

		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
		{ 
			$member=mssql_fetch_assoc($result);

		    	$xml_output .= "\t<item>\n"; 

			$itemid=$member['ItemID'];
			$Expiration=$member['LeasedUntil'];
			$ExpirationS=$member['SecondsLeft'];
                       
			$fname=str_replace (" ", "",$member['FNAME']);
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];

			$xml_output .= "\t<ItemID>" . $itemid . "</ItemID>\n"; 
		 	$xml_output .= "\t<Expiration>" . $ExpirationS . "</Expiration>\n"; 

			$xml_output .= "\t<Category>" . $cat . "</Category>\n"; 
			$xml_output .= "\t<FNAME>" . $fname . "</FNAME>\n"; 
			$xml_output .= "\t<Name>" . $name . "</Name>\n"; 
			$xml_output .= "\t<Description>" . $desc . "</Description>\n"; 

		  	$xml_output .= "\t</item>\n"; 
		}               


		mssql_next_result ($result);

		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
		{ 
			$member=mssql_fetch_assoc($result);

		    	$xml_output .= "\t<item>\n"; 

			$itemid=$member['ItemID'];
			$Expiration=$member['LeasedUntil'];
			$ExpirationS=$member['SecondsLeft'];
                       
			$fname=str_replace (" ", "",$member['FNAME']);
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];

			$xml_output .= "\t<ItemID>" . $itemid . "</ItemID>\n"; 
		 	$xml_output .= "\t<Expiration>" . $ExpirationS . "</Expiration>\n"; 

			$xml_output .= "\t<Category>" . $cat . "</Category>\n"; 
			$xml_output .= "\t<FNAME>" . $fname . "</FNAME>\n"; 
			$xml_output .= "\t<Name>" . $name . "</Name>\n"; 
			$xml_output .= "\t<Description>" . $desc . "</Description>\n"; 

		  	$xml_output .= "\t</item>\n"; 
		}               




		$xml_output .= "</inventory>"; 
		echo $xml_output; 
		exit();
	}

	$xml_output .= "</inventory>"; 
	echo $xml_output; 
	exit();
	
	mssql_close($con);

?>