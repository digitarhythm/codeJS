<?php
require_once("main.php");

if (!isset($_REQUEST['mode'])) {
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

$_file = procarray($_FILES);

function procarray($arr) {
	$ret = array();
	foreach ($arr as $key => $val) {
		if (is_array($val) == true) {
			$val = procarray($val);
		} else {
			$val = htmlspecialchars($val);
		}
		$ret[$key] = $val;
	}
	return $ret;
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
		$ret = saveImageFile($_file, $_arg);
		echo $ret;
		break;
	
	case "createThumbnail":
		$path = $_arg["path"];
		createThumbnail($path);
		break;
	
	case "thumbnailList":
		$path = $_arg["path"];
		$ret = thumbnailList($path);
		echo JSON_encode($ret);
		break;

	case "fileUnlink":
		$fpath = $_arg["fpath"];
		unlink($_HOMEDIR_."/".$fpath);
		echo $fpath;
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
function saveImageFile($_file, $_dir) {
	global $_HOMEDIR_;
	
	$imginfo = $_file[$_dir['key']];
	$tmpname = $imginfo['tmp_name'];
	$type = $imginfo['type'];
	$orgname = $imginfo['name'];
	
	$savedir = $_HOMEDIR_."/Media/Picture";
	switch ($type) {
		case "image/png":
			$ext = ".png";
			break;
		case "image/jpg":
			$ext = ".jpg";
			break;
		case "image/jpeg":
			$ext = ".jpg";
			break;
		case "image/gif":
			$ext = ".gif";
			break;
		default:
			return "{err:0}";
			break;
	}
	
	if(is_uploaded_file($tmpname)){
		$temppath = tempnam($savedir, "img_");
		$savepath = $temppath.$ext;
		move_uploaded_file($tmpname, $savepath);
		unlink($temppath);
		return "{path:'".$savepath."'}";
	} else {
		return "{err:0}";
	}
}

//##########################################################################################
// 指定したパスのファイルリストを返す
//##########################################################################################
function filelist($path, $filter)
{
	global $_HOMEDIR_;
	$dir = opendir($_HOMEDIR_."/".$path);
	$result_f = array();
	$result_d = array();
	while ($fname = readdir($dir)) {
		$target = "$_HOMEDIR_/$path/$fname";
		if (is_dir($target) == true) {
			if (!preg_match("/^\./", $fname)) {
				$result_d[] = $fname;
			}
		} else {
			$ext = pathinfo($fname, PATHINFO_EXTENSION);
			if (in_array($ext, $filter) == true) {
				$result_f[] = $fname;
			}
		}
	}
	$result = array();
	$result["file"] = $result_f;
	$result["dir"] = $result_d;
	return $result;
}

//##########################################################################################
// サムネイルリストを返す
//##########################################################################################
function thumbnailList($path)
{
	deleteAloneThumb($path);
	global $_HOMEDIR_;
	$thumbdir = $_HOMEDIR_."/$path/.thumb";
	$dir = opendir($_HOMEDIR_."/".$path);
	$result_f = array();
	$result_d = array();
	$extarray = array("png", "jpg", "jpeg", "gif");
	while ($fname = readdir($dir)) {
		$target = "$_HOMEDIR_/$path/$fname";
		if (is_dir($target) == false) {
			$ext = pathinfo($fname, PATHINFO_EXTENSION);
			$file = pathinfo($fname, PATHINFO_FILENAME);
			if (in_array($ext, $extarray) == true && is_file($thumbdir."/".$file."_s.".$ext) == true) {
				$result_f[] = $path."/.thumb/".$file."_s.".$ext;
			} else {
				$result_f[] = $path."/".$fname;
			}
		}
	}
	$result = array();
	$result["file"] = $result_f;
	$result["dir"] = $result_d;
	return $result;
}

//##########################################################################################
// 指定したパスにある画像のサムネイルを生成する
//##########################################################################################
function createThumbnail($path)
{
	global $_HOMEDIR_;
	$imgdir = $_HOMEDIR_."/$path";
	$thumbdir = $_HOMEDIR_."/$path/.thumb";
	if (is_dir($thumbdir) == false) {
		return;
	}
	$extarray = array("png", "jpg", "jpeg", "gif");
	$dir = opendir($_HOMEDIR_."/".$path);
	while ($fname = readdir($dir)) {
		$ext = pathinfo($fname, PATHINFO_EXTENSION);
		$file = pathinfo($fname, PATHINFO_FILENAME);
		if (in_array($ext, $extarray) == true && is_file($thumbdir."/".$file."_s.".$ext) == false) {
			exec("convert -resize 120x120 ".$imgdir."/".$fname." ".$thumbdir."/".$file."_s.".$ext);
		}
	}
	deleteAloneThumb($path);
}

//##########################################################################################
// 指定したディレクトリの画像で、親画像が無くなっているサムネイル画像を削除する
//##########################################################################################
function deleteAloneThumb($path)
{
	global $_HOMEDIR_;
	$imgdir = $_HOMEDIR_."/$path";
	$thumbdir = $_HOMEDIR_."/$path/.thumb";
	if (is_dir($thumbdir) == false) {
		return;
	}
	$dir = opendir($thumbdir);
	while ($fname = readdir($dir)) {
		$ext = pathinfo($fname, PATHINFO_EXTENSION);
		$filetmp = pathinfo($fname, PATHINFO_FILENAME);
		preg_match("/(.*)_s/", $filetmp, $match);
		if (isset($match[1]) == false) {
			continue;
		}
		if (is_file($imgdir."/".$match[1].".".$ext) == false) {
			unlink($thumbdir."/".$fname);
		}
	}
}
?>
