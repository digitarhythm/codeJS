#*****************************************
# JSTableViewCell - tableCell base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableViewCell extends JSView
	constructor: (frame) ->
		if (!frame?)
			bounds = getBounds()
			frame = JSRectMake(0, 0, bounds.size.width - 2, 0)
		super(frame)
		@_image = null
		@_imageview = null
		@_textlabel = null
		@_text = ""
		@_textColor = JSColor("black")
		@_textAlignment = "JSTextAlignmentLeft"
		@_bgColor = JSColor("clearColor")
		@_borderColor = JSColor("#d0d8e0")
		@_borderWidth = 1
		
		sidesize = @_frame.size.height
		@tag = "<div id='"+@_objectID+"_cell' style='position:absolute;left:0px;top:0px;width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;z-index:1;'><div id='"+@_objectID+"_text' style='position:relative;left:"+@_frame.size.height+"px;top:0px;width:"+(@_frame.size.width-sidesize-4)+"px;height:"+@_frame.size.height+"px;display:table-cell;vertical-align:middle;'></div></div>"
		
	setText:(@_text)->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").html(@_text)
			
	setTextColor:(@_textColor)->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").css("color", @_textColor)
	
	setTextAlignment:(@_textAlignment)->
		switch @_textAlignment
			when "JSTextAlignmentLeft"
				$(@_viewSelector+"_text").css("text-align", "left")
			when "JSTextAlignmentCenter"
				$(@_viewSelector+"_text").css("text-align", "center")
			when "JSTextAlignmentRight"
				$(@_viewSelector+"_text").css("text-align", "right")
	
	setImage:(@_image)->
		if (!@_image?)
			return
		if ($(@_viewSelector+"_image").length)
			$(@_viewSelector+"_image").remove()
		sidesize = @_frame.size.height
		$(@_viewSelector+"_cell").append("<img id='"+@_objectID+"_image' border='0' src='"+@_image._imagepath+"' style='position:absolute;left:0px;top:0px;width:"+sidesize+"px;height:"+sidesize+"px;'>")
		JSLog("img=%@", @_image._imagepath)

	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_cell").length)
			$(@_viewSelector+"_cell").css("width", frame.size.width)
			$(@_viewSelector+"_cell").css("height", frame.size.height)
			$(@_viewSelector+"_image").css("width", frame.size.height)
			$(@_viewSelector+"_image").css("height", frame.size.height)
			$(@_viewSelector+"_text").css("left", frame.size.height)
			$(@_viewSelector+"_text").css("width", frame.size.width-frame.size.height)
			$(@_viewSelector+"_text").css("height", frame.size.height)

	viewDidAppear:->
		super()
		$(@_viewSelector).append(@tag)
		@setFrame(@_frame)
		@setText(@_text)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		@setImage(@_image)
		$(@_viewSelector).on 'tap', (event)=>
			if (typeof @delegate.didSelectRowAtIndexPath == 'function')
				@delegate.didSelectRowAtIndexPath(@_cellnum, event)
