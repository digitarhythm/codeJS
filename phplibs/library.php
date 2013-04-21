<?php
require_once("main.php");

if (!isset($_REQUEST)) {
	return;
}

$_arg = array();
foreach ($_REQUEST as $key => $val) {
	if (is_array($val) == true) {
		$arr = array();
		foreach ($val as $val2) {
			$arr[] = htmlspecialchars($val2);
		}
		$_arg[$key] = $arr;
	} else {
		$_arg[$key] = htmlspecialchars($val);
	}
}

$_file = array();
foreach ($_FILES as $key => $val) {
	$_file[$key] = htmlspecialchars($val);
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

	case "filelist":
		$path = $_arg["path"];
		$filter = $_arg["filter"];
		$ret = filelist($path, $filter);
		echo JSON_encode($ret);
		break;

	case "uploadfile":
		echo "{code:1}";
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
function writeToFile($data, $fname) {
	$fp = fopen($fname, "w");
	if ($fp == null) {
		return "0";
	}
	fputs ($data, $fp);
	fclose($fp);
	return "1";
}

//##########################################################################################
// アップロードされた画像を保存する
//##########################################################################################
function saveImageFile($_file) {
	$browserFileName = $_file['image']['name'];
	$tempFileName = $_file['image']['tmp_name'];
	$originalFileName = 'image_'.date('YmdHis');
	if(is_uploaded_file($tempFileName)){
		move_uploaded_file($tempFileName, "/web/images/$originalFileName");
	}else{
		return 0;
	}
}

//##########################################################################################
// 指定したパスのファイルリストを返す
//##########################################################################################
function filelist($path, $filter)
{
	global $_DOCDIR_;
	$dir = opendir($_DOCDIR_."/".$path);
	$result = array();
	while ($fname = readdir($dir)) {
		$target = "$_DOCDIR_/$path/$fname";
		if (is_dir($target) == true) {
			continue;
		}
		$ext = pathinfo($fname, PATHINFO_EXTENSION);
		if (in_array($ext, $filter) == true) {
			$result[] = "$path/$fname";
		}
	}
	return $result;
}
?>
