#*****************************************
# JSResponder - touch response recieve class
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSResponder extends JSObject
	constructor: ->
		super()

	didBrowserResize:->
		for o in @_objlist
			o.didBrowserResize()