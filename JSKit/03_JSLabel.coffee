##########################################
# JSLabel - One line text object
# Coded by kouichi.sakazaki 2013.03.25
##########################################

class JSLabel extends JSView
	constructor: (frame = JSRectMake(0, 0, 120, 24)) ->
		super(frame)
		@_textSize =8 
		@_textColor = JSColor("black")
		@_bgColor = JSColor("#f0f0f0")
		@_textAlignment = "JSTextAlignmentCenter"
		@_text = @S("Label")
		@_editable = true
		
	setText: (@_text) ->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").html(@_text.string)

	setTextSize: (@_textSize) ->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector).css("font-size", @_textSize+"pt")

	setTextColor: (@_textColor) ->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector).css("color", @_textColor)
		
	setTextAlignment: (@_textAlignment) ->
		switch @_textAlignment
			when "JSTextAlignmentCenter"
				$(@_viewSelector).css("text-align", "center")
			when "JSTextAlignmentLeft"
				$(@_viewSelector).css("text-align", "left")
			when "JSTextAlignmentRight"
				$(@_viewSelector).css("text-align", "right")
			else
				$(@_viewSelector).css("text-align", "center")
	
	setFrame:(frame)->
		super(frame)
		$(@_viewSelector+"_text").width(frame.size.width)
		$(@_viewSelector+"_text").height(frame.size.height)
	
	setEditable:(@_editable)->
		
		if (!$(@_viewSelector).length)
			return
			
		if (!@_text?)
			@_text.string = ""
			
		#/////////////////////////////////////////////////////////////////
		if (@_editable == true)
			if(@_text.string == "")
				return
			disp = @_text.string
			@_text.string = ""
			tag = "<input id='"+@_objectID+"_text' style='position:absolute;' />"
			x = -4
			y = -4
		else
			if (@_text.string == "" && $(@_viewSelector+"_text").length)
				@_text.setText(@S($(@_viewSelector+"_text").val()))
			disp = @_text.string
			tag = "<div id='"+@_objectID+"_text' style='position:absolute;'></div>"
			x = 0
			y = 0
			
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").remove()
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_text").css("display", "block-inline")
		$(@_viewSelector+"_text").css("line-height",@_frame.size.height+"px")
		if (@_editable == true)
			$(@_viewSelector+"_text").unbind("click").bind "click", (event) =>
				event.stopPropagation()
			
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		$(@_viewSelector+"_text").css("left", x)
		$(@_viewSelector+"_text").css("top", y)
		
		if (@_editable == true)
			$(@_viewSelector+"_text").val(disp)
		else
			$(@_viewSelector+"_text").html(disp)
			
		#/////////////////////////////////////////////////////////////////
		
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").height(@_frame.size.height)
		
	viewDidAppear: ->
		@setEditable(@_editable)
		super()
		$(@_viewSelector).css("display", "block-inline")
		$(@_viewSelector).css("vertical-align", "middle")
		$(@_viewSelector).css("z-index", "1")
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").css("display", "block-inline")
		$(@_viewSelector+"_text").css("line-height",@_frame.size.height+"px")
		$(@_viewSelector+"_text").css("z-index", "1")
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)

