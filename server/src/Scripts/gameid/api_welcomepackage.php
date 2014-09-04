<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	
	$server_key =$_POST['serverkey'];	
	$x_package=$_POST['package'];	
	$x_ability=$_POST['ability'];	
	$x_skill=$_POST['skill'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}

	$api_key = $db_apikey;

	$query="ECLIPSE_WELCOMEPACKAGE '$x_customer', '$api_key', '$x_package', '$x_skill', '$x_ability'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		if(mssql_num_rows($result)>0)
		{
			$member=mssql_fetch_assoc($result);
        
			$result=$member['ResultCode'];
		
			echo "$result\n";
			exit();
		}else 
		{
			echo "0\n";
			exit();
		}
	}else 
	{
		echo "0\n";
		exit();
	}
	
	mssql_close($con);
?>