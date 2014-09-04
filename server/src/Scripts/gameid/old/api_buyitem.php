<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	
	$x_itemid=$_POST['skuid'];	
	$server_key =$_POST['serverkey'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


	$api_key = $db_apikey;

	$query="ECLIPSE_BUYITEM '$x_customer', '$api_key', '$x_itemid'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		if(mssql_num_rows($result)>0)
		{
			//username Successful
			$member=mssql_fetch_assoc($result);
        
			$gamertag=$member['ResultCode'];
		
			echo "$gamertag\n";
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