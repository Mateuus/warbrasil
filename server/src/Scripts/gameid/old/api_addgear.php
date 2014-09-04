<?php

	//Start session	
	session_start();
	
	require_once('dbinfo.inc.php');
	
	$server_key =$_POST['serverkey'];	

	if ($server_key != 'CfFkqQWjfgksYG56893GDhjfjZ20') 
	{
		echo "WRONG SERVER KEY";
		exit();
	}


//1 Day Price<input name="cost1" type="text"/><br>
//3 Day Price<input name="cost3" type="text"/><br>
//7 Day Price<input name="cost7" type="text"/><br>
//30 Day Price<input name="cost30" type="text"/><br>
//60 Day Price<input name="cost60" type="text"/><br>
//90 Day Price<input name="cost90" type="text"/><br>
//Perm Price<input name="costperm" type="text"/><br>
//	$query="INSERT INTO Items_SKU (ItemID, Price, Expiration) VALUES ('$_POST['cost1']',1 )";
//	$result=mssql_query($query);
//	echo "$result\n";

$fname = $_POST['fname'];
$name = $_POST['name'];
$desc = $_POST['desc'];
$cat = $_POST['cat'];
$weight = $_POST['weight'];
$damageperc = $_POST['damageperc'];
$damagemax = $_POST['damagemax'];
$bulk = $_POST['bulk'];
$acc = $_POST['acc'];
$stealth = $_POST['stealth'];


	$query="INSERT INTO Items_Gear (FNAME, Name, Description, Category, Weight, DamagePerc, DamageMax, Bulkiness, Inaccuracy, Stealth) VALUES ( '$fname' ,'$name' ,'$desc','$cat' ,'$weight' ,'$damageperc' ,'$damagemax' ,'$bulk' ,'$acc' ,'$stealth')";
	$result=mssql_query($query);

	//Check whether the query was successful or not
	if($result) 
	{
			echo "$result\n";
			exit();
	}else {
				echo "0\n";
				exit();
	}
	
	mssql_close($con);

?>