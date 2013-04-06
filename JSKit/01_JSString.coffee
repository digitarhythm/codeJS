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
	
	setText:(s) ->
		@string = @escapeHTML_replace_func_rulescached(s.string)

	escapeHTML_replace_func_rulescached:(s) ->
	  s.replace /[&"<>]/g, (c) ->
	    escapeRules[c]
	
	escapeRules =
	  "&": "&amp;"
	  "\"": "&quot;"
	  "<": "&lt;"
	  ">": "&gt;"