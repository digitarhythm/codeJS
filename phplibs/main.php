<?php
// session start
$sid = session_id();
if ($sid != "") {
	session_regenerate_id();
} else {
	session_start();
}
// setup directory
$_HOMEDIR_ = $_SESSION["_HOMEDIR_"];

// parse ini file
$ini = parse_ini_file($_HOMEDIR_."/configs/system.ini");

// add library include path
set_include_path(get_include_path().PATH_SEPARATOR.$_HOMEDIR_."/libs");

// setup smarty
if (!defined("SMARTY_DIR")) {
    define("SMARTY_DIR", $ini["smartypath"]);
}

require_once(SMARTY_DIR . "/Smarty.class.php");

$smarty = new Smarty();
$smarty->template_dir   = "./templates";
$smarty->compile_dir    = "./templates_c";
$smarty->config_dir     = "./configs";
$smarty->cache_dir      = "./cache";
// デリミタ変更
$smarty->left_delimiter = "[{";
$smarty->right_delimiter = "}]";
?>