$ ->
	bounds = getBounds()
	width = bounds.size.width
	height = bounds.size.height
	
	frame = JSRectMake(0, 0, width, height)
	@rootView = new JSWindow(frame)
	@rootView.setBackgroundColor(JSColor("white"))
	@rootView.setClipToBounds(true)

	$("body").append(@rootView._div)
	@rootView.viewDidAppear()
	
	rootID = @rootView._objectID
	
	$(window).resize ->
		frame = getBounds()
		width = frame.size.width
		height = frame.size.height
		$("#"+rootID).width(width)
		$("#"+rootID).height(height)
		
	@applicationMain = new applicationMain(@rootView)
	@applicationMain.didFinishLaunching()
	