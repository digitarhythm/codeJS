##########################################
# JSString - string manage class
# Coded by kouichi.sakazaki 2013.03.31
##########################################

class JSString extends JSObject
	constructor:(@string)->
		super()
		@string = ""
	length:->
		return @string.length

		