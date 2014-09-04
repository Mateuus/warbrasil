<div id="footer">
		<a href="#" class="img_footer1"></a>
		<a href="#" class="img_footer2"></a>
		<a href="#" class="img_footer3"></a>
		<p>(c) 2011-2012<br/>All Rights Reserved<br/>Arktos Entertaiment Group</p>
		<div class="cL"></div>	
</div>

<?php
function do_referrals()
{
	// must work only in https mode, because of https_redir
	if($_SERVER['SERVER_PORT'] != 443)
		return;

	$refId = $_SESSION['reg_referralId'];
	if($refId == 0)
		return;

/*
	// referrers pixels code
	if($refId == 1288932284)  // REFERID_cpmstar
	{
		echo("
<img alt='' width='1' height='1' src='https://server.cpmstar.com/action.aspx?advertiserid=2133&gif=1'/>
		");

		echo ("CPMStar pixel");
		$_SESSION['reg_referralId'] = 0;
	}
*/

	// referrers pixels code
	if($refId == 1288912018 || $refId == 1288911056)  // REFERID_bfm & ADBlindFerret
	{
		echo("
<!-- Blind Ferret Media Tracking Tag - DO NOT MODIFY -->
<script type=\"text/javascript\" language=\"JavaScript\"><!--<![CDATA[
 // Blind Ferret Media Tracker Tag: WIBZ
 var bfmURL = (location.protocol=='https:'?'https://ads.blindferretmedia.com/conversion/track.php':'http://ads.blindferretmedia.com/conversion/track.php');
 document.write(\"<\" + \"script language='JavaScript' type='text/javascript' src='\" + bfmURL + \"?tracker_id=177'><\" + \"\/script>\");
//]]>--></script>
<!-- End Blind Ferret Media Tracking Tag --> 
		");

		echo ("BFM pixel");
		$_SESSION['reg_referralId'] = 0;
	}
}

	do_referrals();

?>