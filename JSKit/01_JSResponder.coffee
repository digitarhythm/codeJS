#*****************************************
# JSResponder - touch response recieve class
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSResponder extends JSObject
  constructor: ->
    super()
    @_event = null
    @_touches = false

  didBrowserResize:->
    for o in @_objlist
      o.didBrowserResize()

  locationView:->
    pt = new JSPoint()
    pt.x = @_event.offsetX
    pt.y = @_event.offsetY
    return pt
