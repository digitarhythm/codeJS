#*****************************************
# JSTextField - One line text object
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSTextField extends JSControl
	constructor: (frame = JSRectMake(0, 0, 120, 24)) ->
		super(frame)
		@_textSize = 12
		@_textColor = JSColor("black")
		@_bgColor = JSColor("#f0f0f0")
		@_textAlignment = "JSTextAlignmentCenter"
		@_text = ""
		@_editable = true
		
	setText: (@_text) ->
		if ($(@_viewSelector+"_text").length)
			if (@_editable == true)
				$(@_viewSelector+"_text").val(@_text)
			else
				$(@_viewSelector+"_text").html(@_text)
		else

	setTextSize: (@_textSize) ->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").css("font-size", @_textSize+"pt")

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
	
	setEditable:(editable)->
		if (!$(@_viewSelector).length)
			@_editable = editable
			return
			
		if (editable == true)
			if ($(@_viewSelector+"_text").length)
				if (@_editable == false)
					@_text = $(@_viewSelector+"_text").html()
				else
					@_text = $(@_viewSelector+"_text").val()
			
			tag = "<input type='text' id='"+@_objectID+"_text' style='position:absolute;z-index:1;' value='"+@_text+"' />"
			x = -4
			y = -4
		else
			if (!$(@_viewSelector+"_text").length)
				disp = @_text
			else
				if (@_editable == true)
					disp = $(@_viewSelector+"_text").val()
				else
					disp = @_text
			tag = "<div id='"+@_objectID+"_text' style='position:absolute;z-index:1;'>"+disp+"</div>"
			x = 0
			y = 0
		@_editable = editable
		
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").remove()
		
		$(@_viewSelector).append(tag)
		if (@_editable == true)
			$(@_viewSelector+"_text").unbind("click").bind "click", (event) =>
				event.stopPropagation()
			$(@_viewSelector+"_text").bind "change", =>
				@_text = $(@_viewSelector+"_text").val()
		
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		$(@_viewSelector+"_text").css("left", x)
		$(@_viewSelector+"_text").css("top", y)
		$(@_viewSelector+"_text").html(disp)
		
		#if (@_editable == true)
		#	$(@_viewSelector+"_text").val(disp)
		#else
		#	$(@_viewSelector+"_text").html(disp)
		
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").height(@_frame.size.height)

	viewDidAppear: ->
		super()
		@setEditable(@_editable)
		$(@_viewSelector).css("vertical-align", "middle")
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").css("line-height",@_frame.size.height+"px")
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)

