##########################################
# JSFileManager - File manage clss
# Coded by kouichi.sakazaki 2013.03.31
##########################################

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
		$.post 'syslibs/library.php',
			mode: 'stringWithContentsOfFile'
			fname: fname
			(data) =>
				@readaction(data)
  
	writeToFile:(fpath, string, encoding, @saveaction)->
		$.post 'syslibs/library.php',
			mode: 'writeToFile'
			fname: fpath
			data: string
			, (data) =>
				@saveaction()

	fileList:(fpath, type, @listaction)->
		$.post "syslibs/library.php",
			mode: "filelist"
			path: fpath
			filter: type
		,(filelist) =>
			if (@listaction?)
				@listaction(filelist)