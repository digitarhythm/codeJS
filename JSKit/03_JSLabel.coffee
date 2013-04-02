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
		@_text = "Label"
		@_editable = true
		
	setText: (@_text) ->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").html(@_text)

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
	
	setEditable:(@_editable)->
		
		if (!$(@_viewSelector).length)
			return
			
		if (!@_text?)
			@_text = ""
			
		#/////////////////////////////////////////////////////////////////
		if (@_editable == true)
			if(@_text == "")
				return
			disp = @_text
			@_text = ""
			tag = "<input id='"+@_objectID+"_text' style='position:absolute;' />"
			x = -4
			y = -4
		else
			if (@_text == "" && $(@_viewSelector+"_text").length)
				@_text = $(@_viewSelector+"_text").val()
			disp = @_text
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
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").css("display", "block-inline")
		$(@_viewSelector+"_text").css("line-height",@_frame.size.height+"px")
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)

