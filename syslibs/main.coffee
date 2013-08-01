$ ->
	bounds = getBounds()
	width = bounds.size.width
	height = bounds.size.height

	frame = JSRectMake(0, 0, width, height)
	@rootView = new JSWindow(frame)
	@rootView.setBackgroundColor(JSColor("white"))
	@rootView.setClipToBounds(true)
	@rootView.setBackgroundColor(JSColor("clearColor"))

	$("body").append(@rootView._div)
	@rootView.viewDidAppear()
	
	rootID = @rootView._objectID
	
	@applicationMain = new applicationMain(@rootView)
	@applicationMain.didFinishLaunching()
	
	$(window).resize =>
		frame = getBounds()
		width = frame.size.width
		height = frame.size.height
		$("#"+rootID).width(width)
		$("#"+rootID).height(height)
		if (typeof @applicationMain.didBrowserResize == "function")
			@applicationMain.didBrowserResize()
		for o in @rootView._objlist
			o.didBrowserResize()
	
	Array.prototype.indexOfObject = (target)->
		for i in [0...@.length]
			val = @[i]
			if (target == val)
				return i