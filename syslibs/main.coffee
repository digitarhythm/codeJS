@rootView = undefined
$ =>
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
		angle = Math.abs(window.orientation)
		if (typeof @applicationMain.didBrowserResize == "function")
			@applicationMain.didBrowserResize()
		if (isAndroid() == true)
			if (typeof @applicationMain.didBrowserRotate == "function")
				@applicationMain.didBrowserRotate(angle)
		for o in @rootView._objlist
			if (typeof o.didBrowserResize == "function")
				o.didBrowserResize()
			if (isAndroid() == true)
				if (typeof o.didBrowserRotate == "function")
					o.didBrowserRotate(angle)
	
	if (isAndroid() == false)
		$(window).bind 'orientationchange', =>
			angle = Math.abs(window.orientation)
			if (typeof @applicationMain.didBrowserRotate == "function")
				@applicationMain.didBrowserRotate(angle)
			for o in @rootView._objlist
				if (typeof o.didBrowserRotate == "function")
					o.didBrowserRotate(angle)
	
	window.cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame || window.webkitCancelAnimationFrame || window.msCancelAnimationFrame

getRootView = =>
	return @rootView
	
