#*****************************************
# JSActivityIndicatorView - loading indicator control class
# Coded by kouichi.sakazaki 2013.05.16
#*****************************************

class JSActivityIndicatorView extends JSView
	constructor: (frame)->
		super(frame)
		@_bgColor = JSColor("clearColor")
		@_animating = true
		@activityIndicatorViewStyle = "JSActivityIndicatorViewStyleGray"

	startAnimating:->
		@setHidden(false)
		@_animating = true

	stopAnimating:->
		@setHidden(true)
		@_animating = false

	viewDidAppear:->
		super()
		if (@activityIndicatorViewStyle == "JSActivityIndicatorViewStyleGray")
			indicator_img = "loading_indicator_gray.gif"
		else if (@activityIndicatorViewStyle == "JSActivityIndicatorViewStyleWhite")
			indicator_img = "loading_indicator_white.gif"
		else
			return
		tag = "<img id='"+@_objectID+"_indicator' src='syslibs/Picture/"+indicator_img+"' style='position:absolute;z-index:1;'>"
		if ($(@_viewSelector+"_indicator").length)
			$(@_viewSelector+"_indicator").remove()
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_indicator").width(@_frame.size.width)
		$(@_viewSelector+"_indicator").height(@_frame.size.height)
		if (@_animating == true)
			@setHidden(false)
		else
			@setHidden(true)
