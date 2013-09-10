#*****************************************
# JSTableViewCell - tableCell base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableViewCell extends JSView
	constructor: (frame) ->
		if (!frame?)
			bounds = getBounds()
			frame = JSRectMake(0, 0, bounds.size.width - 1, 64)
		super(frame)
		@_image = null
		@_imageview = null
		@_textlabel = null
		@_text = ""
		@_image = null
		@_bgColor = JSColor("clearColor")
		
	setText:(@_text)->
		if (@_textview?)
			@_textview.setText(@_text)
	
	setImage:(image)->
		if (@_imageview?)
			if (!@_image?)
				@_image = new JSImage()
			@_image.imageNamed(image)
			@_imageview.setImage(@_image)

	viewDidAppear:->
		super()
		@_self.addTapGesture =>
			if (typeof @delegate.didSelectRowAtIndexPath == 'function')
				@delegate.didSelectRowAtIndexPath(@_cellnum)
		$(@_viewSelector).css("border-bottom", "solid 1px #d0d8e0")
		sidesize = @_frame.size.height - 4
		@_imageview = new JSImageView(JSRectMake(4, 4, sidesize, sidesize))
		@_imageview.setBackgroundColor(JSColor("white"))
		if (@_image?)
			@setImage(@_image)
		@_self.addSubview(@_imageview)
		@_textlabel = new JSLabel(JSRectMake(sidesize, 0, @_frame.size.width - sidesize - 8, @_frame.size.height))
		@_textlabel.setBackgroundColor(JSColor("clearColor"))
		@_textlabel.setTextAlignment("JSTextAlignmentLeft")
		@_textlabel.setTextSize(14)
		@_textlabel.setText(@_text)
		@_self.addSubview(@_textlabel)
