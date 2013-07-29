<?php /* Smarty version 2.6.26, created on 2013-07-29 19:15:04
         compiled from index.tmpl */ ?>
<?php echo '<?php'; ?>

	$_HOMEDIR_ = realpath(__DIR__);
	$sid = session_id();
	if ($sid != "") {
		session_regenerate_id();
	} else {
		session_start();
	}
	set_include_path(get_include_path().PATH_SEPARATOR.$_HOMEDIR_."/syslibs");
	require_once("main.php");
<?php echo '?>'; ?>

	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="<?php echo $this->_tpl_vars['jqueryuicss']; ?>
" />
		<script type="text/javascript" charset="UTF-8" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="http://code.jquery.com/ui/1.10.2/jquery-ui.min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/jquery.ui.touch-punch.min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/jquery.upload-1.0.2.min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/imgLiquid-min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/three.min.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/coffee-script.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/library.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/JSKit.js"></script>
		<script type="text/javascript" charset="UTF-8" src="usrlibs/applicationMain.js"></script>
		<script type="text/javascript" charset="UTF-8" src="syslibs/main.js"></script>
<?php echo '<?php'; ?>

		$link_arr = array();	
		$ext = "js";
		$search_dir = "usrlibs";
		$dir = opendir($_HOMEDIR_."/".$search_dir);
		while ($fname = readdir($dir)) {
			if ($fname != "applicationMain.js" && preg_match("/.*\.".$ext."$/", $fname)) {
				$link_arr[] = $search_dir."/".$fname;
			}
		}
		$search_dir = "Plugins";
		$dir = opendir($_HOMEDIR_."/".$search_dir);
		while ($fname = readdir($dir)) {
			if ($fname != "applicationMain.js" && preg_match("/.*\.".$ext."$/", $fname)) {
				$link_arr[] = $search_dir."/".$fname;
			}
		}
		sort($link_arr);
		foreach ($link_arr as $f) {
<?php echo '?>'; ?>
			<script type="text/javascript" charset="UTF-8" src="<?php echo '<?php'; ?>
 echo $f <?php echo '?>'; ?>
"></script>
<?php echo '<?php'; ?>
	}
<?php echo '?>'; ?>

	</head>
	<body marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">
	</body>
	</html>