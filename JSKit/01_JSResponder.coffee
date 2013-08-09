#*****************************************
# JSResponder - touch response recieve class
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSResponder extends JSObject
	constructor: ->
		super()
		@_event = null
		@_touches = false

	initResponder:->
		###
		$("#"+@_objectID).on "vmousedown", (event)=>
			@_touches = true
			if (typeof @touchesBegan == 'function')
				@_event = event
				@touchesBegan(event)
		$("#"+@_objectID).on "vmousemove", (event)=>
			if (typeof @touchesMoved == 'function' && @_touches == true)
				@_event = event
				@touchesMoved(event)
		$("#"+@_objectID).on "vmouseup", (event)=>
			@_touches = false
			if (typeof @touchesEnded == 'function')
				@_event = event
				@touchesEnded(event)
		$("#"+@_objectID).on "vmousecancel", (event)=>
			@_touches = false
			if (typeof @touchesCanceled == 'function')
				@_event = event
				@touchesCanceled(event)
		###

	didBrowserResize:->
		for o in @_objlist
			o.didBrowserResize()

	locationView:->
		pt = new JSPoint()
		pt.x = @_event.offsetX
		pt.y = @_event.offsetY
		return pt