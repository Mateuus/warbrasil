<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$x_customer=$_POST['sessiontoken'];	
	$server_key =$_POST['serverkey'];	
	$skillid =$_POST['skillid'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


	$api_key = $db_apikey;

	$query="ECLIPSE_GETDATA1 '$x_customer', '$api_key'";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
		if(mssql_num_rows($result)>0)
		{
			//username Successful
			$member=mssql_fetch_assoc($result);

			$Skills=$member['Skills'];

			mssql_next_result ( $result );
			$member=mssql_fetch_assoc($result);

			$SP=$member['SkillPoints'];

			$SkillVal = $Skills[$skillid];
        		//echo "$Skills    => $SP<br>";
        		//echo "$SkillVal <br>";

			if ($SkillVal == 0 ) $SP = $SP-1;
			if ($SkillVal == 1 ) $SP = $SP-1;
			if ($SkillVal == 2 ) $SP = $SP-2;
			if ($SkillVal == 3 ) $SP = $SP-2;
			if ($SkillVal == 4 ) $SP = $SP-3;

			if ($SP >-1)
			{
			  $SkillVal = $SkillVal +1;
			  $Skills[$skillid] = $SkillVal;

        		  //echo "New Skills $Skills <br>";

			  $query="ECLIPSE_SETDATA1 '$x_customer', '$api_key', '$SP', '$Skills'";
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