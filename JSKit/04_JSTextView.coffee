##########################################
# JSTextView - User Interactive Text View
# Coded by kouichi.sakazaki 2013.03.26
##########################################

class JSTextView extends JSScrollView
	constructor: (frame) ->
		super(frame)
		@_editable = true
		@_userInteractive = true
		@_textSize = 8 
		@_textColor = JSColor("black")
		@_bgColor = JSColor("white")
		@_borderColor = JSColor("clearColor")
		@_borderWidth = 0
		@_textAlignment = "JSTextAlignmentLeft"
		@_text = @S("")

	setText: (@_text) ->
		@_text.string = @_text.string.replace(/\n/gi, "[br]")
		@_text.string = @_text.string.replace(/<br>/gi, "[br]")
		if ($(@_viewSelector+"_textarea").length)
			@setEditable(@_editable)
		
	setTextSize: (@_textSize) ->
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").css("font-size", @_textSize+"pt")
			
	setTextColor: (@_textColor) ->
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").css("color", @_textColor)

	setFrame: (frame) ->
		super(frame)
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").width(frame.size.width)
			$(@_viewSelector+"_textarea").height(frame.size.height)
		
	setUserInteraction: (@_userInteraction) ->
		
	setEditable: (@_editable) ->
		if (!$(@_viewSelector).length)
			return
			
		if (!@_text?)
			@_text = @S("")
			
		if (@_editable == true)
			disp = @_text.string.replace(/\[br\]/g, "\n")
			@_text.string = ""
			tag = "<textarea id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'></textarea>"
			x = -2
			y = -2
		else
			if (@_text.string == "" && $(@_viewSelector+"_textarea").length)
				@_text.string = $(@_viewSelector+"_textarea").val()
				@_text.string = @_text.string.replace(/\n/g, "[br]")
			disp = @_text.string.replace(/\[br\]/g, "<br>")
			tag = "<div id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'></div>"
			x = 0
			y = 0
			
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").remove()
		$(@_viewSelector).append(tag)
		if (@_editable == true)
			$(@_viewSelector+"_textarea").unbind("click").bind "click", (event) =>
				event.stopPropagation()
			
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		@setUserInteraction(@_userInteraction)	
		$(@_viewSelector+"_textarea").css("left", x)
		$(@_viewSelector+"_textarea").css("top", y)
		$(@_viewSelector+"_textarea").html(disp)
		
		$(@_viewSelector+"_textarea").width(@_frame.size.width)
		$(@_viewSelector+"_textarea").height(@_frame.size.height)
		
	setTextAlignment: (@_textAlignment) ->
		switch @_textAlignment
			when "JSTextAlignmentCenter"
				$(@_viewSelector+"_textarea").css("text-align", "center")
			when "JSTextAlignmentLeft"
				$(@_viewSelector+"_textarea").css("text-align", "left")
			when "JSTextAlignmentRight"
				$(@_viewSelector+"_textarea").css("text-align", "right")
			else
				$(@_viewSelector+"_textarea").css("text-align", "center")
	
	viewDidAppear: ->
		super()
		@setEditable(@_editable)
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		@setUserInteraction(@_userInteraction)	
		$(@_viewSelector+"_textarea").width(@_frame.size.width)
		$(@_viewSelector+"_textarea").height(@_frame.size.height)
		if (@_editable == true)
			$(@_viewSelector+"_textarea").unbind("click").bind "click", (event) =>
				event.stopPropagation()
		


