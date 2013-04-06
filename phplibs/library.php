<?php
require_once("main.php");

if (!isset($_REQUEST)) {
	return;
}

$_arg = array();
foreach ($_REQUEST as $key => $val) {
	$_arg[$key] = htmlspecialchars($val);
}

$mode = $_arg["mode"];
switch ($mode) {
	case "stringWithContentsOfFile":
		$fname = $_arg["fname"];
		$ret = stringWithContentsOfFile($fname);
		echo $ret;
		break;
}

//##########################################################################################
//##########################################################################################
//##########################################################################################

function stringWithContentsOfFile($fname) {
	global $_DOCDIR_;
	$str = file_get_contents($_DOCDIR_."/".$fname);
	return $str;
}
?>
