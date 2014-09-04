<?php

function invitekey_encode($CustomerID)
{
	$invitekey_xorid = 0x4A5B2F38;

	$l1 = base_convert($CustomerID ^ $invitekey_xorid, 10, 36);
	return "A" . $l1;
}

function invitekey_decode($InviteKey)
{
	global $invitekey_xorkey;

	if(substr($InviteKey, 0, 1) == "A")
	{
		// v1 of invite key encryption
		$invitekey_xorid = 0x4A5B2F38;
		$l1 = base_convert(substr($InviteKey, 1), 36, 10);

		$CustomerID = $l1 ^ $invitekey_xorid;
		return $CustomerID;
	}

	return 0;
}

?>