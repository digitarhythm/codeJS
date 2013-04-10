##########################################
# JSString - string manage class
# Coded by kouichi.sakazaki 2013.03.31
##########################################

class JSString extends JSObject
	constructor:->
		super()
		@string = ""

	length:->
		return @string.length
	
	setText:(str) ->
		@string = @escapeHTML_replace_func_rulescached(str.string)

	escapeHTML_replace_func_rulescached:(s) ->
	  s.replace /[&"<>]/g, (c) ->
	    escapeRules[c]
	
	escapeRules =
	  "&": "&amp;"
	  "\"": "&quot;"
	  "<": "&lt;"
	  ">": "&gt;"

	stringWithContentsOfFile:(fname, @readaction)->	  
		if (!fname.string?)
			return
		$.post 'syslibs/library.php',
			mode: 'stringWithContentsOfFile'
			fname: fname.string
			(data) => @readaction(data)
  
	writeToFile:(fpath, encoding, @saveaction)->
		$.post 'syslibs/library.php',
			mode: 'writeToFile'
			fname: fpath.string
			data: @string
			(data) => @saveaction(data)

	isEqualToString:(str)->
		if (@string == str.string)
			return true
		else
			return false

	stringByAppendingString:(str)->
		ret = new JSString()
		ret.string = @string+str.string
		return ret