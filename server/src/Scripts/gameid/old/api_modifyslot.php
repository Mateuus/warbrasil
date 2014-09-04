<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	

	$api_key = $db_apikey;
	$server_key =$_POST['serverkey'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


		$SlotID=$_POST['SlotID'];
		$Slot=$_POST['SlotInfo'];

	$query="ECLIPSE_UPDATELOADOUT '$x_customer', '$api_key', '$SlotID','$Slot'";

	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
//		if(mssql_num_rows($result)>0)
//		{
			//username Successful
//			$member=mssql_fetch_assoc($result);
			exit();
//		}else 
//			{
//				echo "XXX GETPROFILE FAILED\n";
//				exit();
//			}
	}else {
//				echo "XXX GETPROFILE FAILED\n";
				exit();
	}
	

	echo "1\n";
	mssql_close($con);

?>