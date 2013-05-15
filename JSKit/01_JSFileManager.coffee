#*****************************************
# JSFileManager - File manage clss
# Coded by kouichi.sakazaki 2013.03.31
#*****************************************

class JSFileManager extends JSObject
	constructor:->
		super()

	escapeHTML:(s) ->
	  s.replace /[&"<>]/g, (c) ->
	    escapeRules[c]
	
	escapeRules =
	  "&": "&amp;"
	  "\"": "&quot;"
	  "<": "&lt;"
	  ">": "&gt;"

	stringWithContentsOfFile:(fname, @readaction)->	  
		if (!fname?)
			return
		$.post "syslibs/library.php",
			mode: "stringWithContentsOfFile"
			fname: fname
			(data) =>
				if (@readaction?)
					@readaction(data)
  
	writeToFile:(path, string, @saveaction)->
		$.post "syslibs/library.php",
			mode: "writeToFile"
			fname: path
			data: string
			, (ret) =>
				if (@saveaction?)
					@saveaction(parseInt(ret))

	fileList:(path, type, @listaction)->
		$.post "syslibs/library.php",
			mode: "filelist"
			path: path
			filter: type
		,(filelist) =>
			if (@listaction?)
					@listaction(filelist)

	thumbnailList:(path, @imagelistaction)->
		$.post "syslibs/library.php",
			mode: "thumbnailList"
			path: path
		,(filelist) =>
			if (@imagelistaction?)
					@imagelistaction(filelist)

	createDirectoryAtPath:(path, @creatediraction)->
		$.post "syslibs/library.php",
			mode: "createDirectoryAtPath"
			path: path
		, (ret) =>
			if (@creatediraction?)
				@creatediraction(parseInt(ret))

	removeItemAtPath:(path, @removeaction)->
		$.post "syslibs/library.php",
			mode: "removeFile"
			path: path
		, (ret) =>
			JSLog(ret)
			if (@removeaction?)
				@removeaction(parseInt(ret))

	moveItemAtPath:(file, path, @moveaction)->
		$.post "syslibs/library.php",
			mode: "moveFile"
			file: file
			toPath: path
		, (ret) =>
			if (@moveaction?)
				@moveaction(parseInt(ret))