##########################################
# JSObject - base class of all Object
# Coded by kouichi.sakazaki 2013.03.25
##########################################

class JSObject
	constructor: ->
		@_self = @
		@_objectID = UniqueID()
		@tag = ""

	S:(str)->
		obj = new JSString(str)
		return obj