#*****************************************
# JSWebView - Web site handling class
# Coded by kouichi.sakazaki 2015.10.05
#*****************************************

class JSWebView extends JSScrollView
  constructor: (frame)->
    super(frame)
    @scalesPageToFit = false
    @loading = false
    @_request = undefined

  destructor:->
    super()

  didBrowserResize:->
    for obj in @_objlist
      if (typeof obj.didBrowserResize == 'function')
        obj.didBrowserResize()

  loadRequest:(@_request)->
    $("#"+@_objectID+"_webview").remove()
    @viewDidAppear()

  viewDidAppear:->
    tag  = "<div id='"+@_objectID+"_webview' style='overflow:hidden; position:absolute; width:"+@_frame.size.width+"px; height:"+@_frame.size.height+"px;'>"
    tag += "<iframe src='"+@_request+"' style='width:100%; height:100%; border:0ox;'></iframe>"
    tag += "</div>"
    $(@_viewSelector).append(tag)
