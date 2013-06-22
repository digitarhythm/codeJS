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
	
	$(window).resize =>
		frame = getBounds()
		width = frame.size.width
		height = frame.size.height
		$("#"+rootID).width(width)
		$("#"+rootID).height(height)
		for o in @rootView._objlist
			o.didBrowserResize()
	
	@applicationMain = new applicationMain(@rootView)
	@applicationMain.didFinishLaunching()
	
	Array.prototype.indexOfObject = (target)->
		for i in [0...@.length]
			val = @[i]
			if (target == val)
				return i