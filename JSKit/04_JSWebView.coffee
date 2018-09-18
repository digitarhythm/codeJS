#*****************************************
# JSWebView - Web site handling class
# Coded by Hajime Oh-yake 2015.10.05
#*****************************************

class JSWebView extends JSScrollView
    constructor: (frame)->
        super(frame)
        @scalesPageToFit = false
        @loading = false
        @_request = undefined

    destructor:->
        super()

    reload:->
        @loadRequest(@_request)

    loadRequest:(@_request)->
        $(@_viewSelector+"_webview").remove()
        @viewDidAppear()

    setCornerRadius:(cornerradius)->
        super(cornerradius)
        $(@_viewSelector+"_webview").css("border-radius", cornerradius+"px")

    viewDidAppear:->
        super()
        tag = "<div id='"+@_objectID+"_webview' style='position:absolute; overflow:hidden; width:"+@_frame.size.width+"px; height:"+@_frame.size.height+"px; border-radius:"+@_cornerRadius+"px;'>"
        if (@_request?)
            tag += "<iframe src='"+@_request+"' style='position:absolute; width:"+@_frame.size.width+"px; height:"+@_frame.size.height+"px; border:0px; margin:0px 0px 0px 0px'></iframe>"
        tag += "</div>"
        $(@_viewSelector).append(tag)
