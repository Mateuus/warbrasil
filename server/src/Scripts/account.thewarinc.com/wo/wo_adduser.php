<?php
//error_reporting(E_ALL & ~E_NOTICE);

// #################### DEFINE IMPORTANT CONSTANTS #######################
define('THIS_SCRIPT', 'wo_adduser');
define('CSRF_PROTECTION', true);
define('CONTENT_PAGE', false);

define('VB_AREA', 'External'); 
define('SKIP_SESSIONCREATE', 1); 
define('SKIP_USERINFO', 1); 

define('CWD', '..');
require_once(CWD . '/includes/init.php');
require_once(CWD . '/includes/functions_misc.php');

	$WO_SecKey = $_REQUEST['WOKey'];
	if($WO_SecKey != 'f$4gkzkdk3zj')
	{
		die('fraud reported');
	}

	$username = $_REQUEST['user'];
	$password = $_REQUEST['passwd'];
	$email    = $_REQUEST['email'];
	if(!isset($username))	die('d1');
	if(!isset($password))	die('d2');
	if(!isset($email))	die('d3');
	
	// check if user already exist
	if($vbulletin->userinfo = $vbulletin->db->query_first("SELECT userid, usergroupid, membergroupids, infractiongroupids, username, password, salt FROM " . TABLE_PREFIX . "user WHERE username = '" . $vbulletin->db->escape_string(htmlspecialchars_uni($username)) . "'"))
	{
		echo "1EXIST<br>";
		die();
	}

	$userdata =& datamanager_init('User', $vbulletin, ERRTYPE_ARRAY); 
	$userdata->set('username',    $username);
	$userdata->set('email',       $email);
	$userdata->set('password',    $password);
	$userdata->set('usergroupid', 2); 
	$userdata->set_bitfield('options', 'adminemail', true);
	$userdata->set_bitfield('options', 'receivefriendemailrequest', true);

	$userdata->pre_save();

	// check for errors
	if (!empty($userdata->errors))
	{
		echo "2FAIL<br>";
		foreach ($userdata->errors AS $index => $error)
		{
			echo "<li>$error</li>";
		}
		exit();
	}

	// save the data
	$userid = $userdata->save();

	echo "0OK<br>";
	echo "user created : $userid<br>";

?>