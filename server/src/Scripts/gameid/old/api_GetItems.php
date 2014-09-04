<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\"?>\n"; 
$xml_output .= "<itemmall>\n"; 


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

	$query="ECLIPSE_GETALLITEMS '$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{


		for($x = 0 ; $x < mssql_num_rows($result) ; $x++)
		{ 
			$member=mssql_fetch_assoc($result);

		    	$xml_output .= "\t<item>\n"; 

                        
			$fname=str_replace (" ", "",$member['FNAME']);
			$itemid=$member['ItemID'];
			$cat=$member['Category'];
			$name=$member['Name'];
			$desc=$member['Description'];
			$Cost1=$member['Cost1Day'];
			$Cost3=$member['Cost3Day'];
			$Cost7=$member['Cost7Day'];
			$Cost30=$member['Cost30Day'];
			$CostP=$member['CostPerm'];

			$xml_output .= "\t<ItemID>" . $itemid . "</ItemID>\n"; 
			$xml_output .= "\t<Category>" . $cat . "</Category>\n"; 
			$xml_output .= "\t<FNAME>" . $fname . "</FNAME>\n"; 
			$xml_output .= "\t<Name>" . $name . "</Name>\n"; 
			$xml_output .= "\t<Description>" . $desc . "</Description>\n"; 
			$xml_output .= "\t<Cost1>" . $Cost1 . "</Cost1>\n"; 
			$xml_output .= "\t<Cost3>" . $Cost3 . "</Cost3>\n"; 
			$xml_output .= "\t<Cost7>" . $Cost7 . "</Cost7>\n"; 
			$xml_output .= "\t<Cost30>" . $Cost30 . "</Cost30>\n"; 
			$xml_output .= "\t<CostP>" . $CostP . "</CostP>\n"; 

		  	$xml_output .= "\t</item>\n"; 
		}               

		$xml_output .= "</itemmall>"; 
		echo $xml_output; 
		exit();
	}

	$xml_output .= "</itemmall>"; 
	echo $xml_output; 
	exit();
	
	mssql_close($con);

?>