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
		
	case "writeToFile":
		$fname = $_arg["fname"];
		$data = $_arg["data"];
		$ret = writeToFile($data, $fname);
		echo $ret;
		break;
}

//##########################################################################################
//##########################################################################################
//##########################################################################################

//##########################################################################################
// 指定されたファイルを読み込む
//##########################################################################################
function stringWithContentsOfFile($fname) {
	global $_HOMEDIR_;
	$str = file_get_contents($_HOMEDIR_."/".$fname);
	return $str;
}

//##########################################################################################
// 渡されたデータを指定されたファイル名で保存する
//##########################################################################################
function writeToData($data, $fname) {
	$fp = fopen($fname, "w");
	if ($fp == null) {
		return "0";
	}
	fputs ($data, $fp);
	fclose($fp);
	return "1";
}
?>
