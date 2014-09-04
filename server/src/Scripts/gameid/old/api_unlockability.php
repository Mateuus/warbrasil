<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	
	$server_key =$_POST['serverkey'];	
	$abilityid =$_POST['abilityid'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


	$api_key = $db_apikey;

	$query="ECLIPSE_GETDATA2 '$x_customer', '$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		if(mssql_num_rows($result)>0)
		{
			//username Successful
			$member=mssql_fetch_assoc($result);

			$Abilities=$member['Abilities'];
			$GP=$member['GamePoints'];

			$Val = $Abilities[$abilityid];
        		//echo "$Skills    => $SP<br>";
        		//echo "$SkillVal <br>";

			if ($Val == 0 ) $GP = $GP-1000;

			if ($GP >-1 )
			{
			  $Val = '1';
			  $Abilities[$abilityid] = $Val;

        		  //echo "New Skills $Skills <br>";

			  $query="ECLIPSE_SETDATA2 '$x_customer', '$api_key', '$GP', '$Abilities'";
			  $result=mssql_query($query);
			  echo "1\n";
			  exit();

			}

			echo "-1\n";
			exit();
		}else 
			{
				echo "0\n";
				exit();
			}
	}else {
				echo "0\n";
				exit();
	}
	
	mssql_close($con);

?>