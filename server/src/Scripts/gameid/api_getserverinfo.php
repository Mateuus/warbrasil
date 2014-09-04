<?php

header("Content-type: text/xml"); 

$xml_output = "<?xml version=\"1.0\" ?>\n"; 
$xml_output .= "<Startup>\n"; 

$xml_output .= "\t<NewsURL name=\"Playtest time\" date=\"01.06.2011\" >\n "; 
$xml_output .= "\t<URL file=\"http://www.thewarinc.com/index.php?id=19\"/>\n";
$xml_output .= "\t</NewsURL>\n"; 

$xml_output .= "\t<NewsURL name=\"New screenshots\" date=\"01.02.2011\" >\n "; 
$xml_output .= "\t<URL file=\"http://www.thewarinc.com/media.php\"/>\n";
$xml_output .= "\t</NewsURL>\n"; 

$xml_output .= "\t<NewsURL name=\"Goto your account\" date=\"11.12.2010\" >\n "; 
$xml_output .= "\t<URL file=\"http://account.thewarinc.com\"/>\n";
$xml_output .= "\t</NewsURL>\n"; 

$xml_output .= "<ServerInfo status=\"ONLINE\"/>\n";

$xml_output .= "</Startup>\n\n"; 
echo  $xml_output; 
exit();

?>

