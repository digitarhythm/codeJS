#*****************************************
# JSTextField - One line text object
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSTextField extends JSControl
	constructor: (frame = JSRectMake(0, 0, 120, 24)) ->
		super(frame)
		@_textSize = 10
		@_textColor = JSColor("black")
		@_bgColor = JSColor("#f0f0f0")
		@_textAlignment = "JSTextAlignmentCenter"
		@_text = ""
		@_editable = true
		@_action = null
		@_focus = false
		@_placeholder = ""

	getText:->
		if (@_editable == true)
			text = $(@_viewSelector+"_text").val()
		else
			text = @_text
			
		return text

	setText: (@_text) ->
		if ($(@_viewSelector+"_text").length)
			if (@_editable == true)
				$(@_viewSelector+"_text").val(@_text)
			else
				disp = JSEscape(@_text)
				$(@_viewSelector+"_text").html(disp)

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
		frame.size.width -= 5
		frame.origin.x += 2
		super(frame)
		$(@_viewSelector+"_text").width(frame.size.width)
		$(@_viewSelector+"_text").height(frame.size.height)
	
	setPlaceholder:(@_placeholder)->
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").attr("placeholder", @_placeholder)
	
	setEditable:(editable)->
		if (!$(@_viewSelector).length)
			@_editable = editable
			return
		
		if (editable == true) # 編集可能モード
			
			if (@_editable == true) # モード変更前が編集可能モード
				
				if (!$(@_viewSelector+"_text").length)
					tag = "<input type='text' id='"+@_objectID+"_text' style='position:absolute;z-index:1;height:"+@_frame.size.height+"px;' value='"+@_text+"' />"
				else
					@_text = $(@_viewSelector+"_text").val()
					return
			
			else # モード変更前が編集不可モード
				
				disp = JSEscape(@_text)
				tag = "<input type='text' id='"+@_objectID+"_text' style='position:absolute;z-index:1;height:"+@_frame.size.height+"px;' value='"+disp+"' />"
				
			x = -2
			y = -2
			
		else # 編集不可モード
			
			if (@_editable == true) # モード変更前が編集可能モード
				
				@_text = $(@_viewSelector+"_text").val()
				text = JSEscape(@_text)
				disp = text.replace(/\n/g, "<br>")
				tag = "<div id='"+@_objectID+"_text' style='position:absolute;z-index:1;overflow:hidden;'>"+disp+"</div>"
			
			else # モード変更前が編集不可モード
			
				text = JSEscape(@_text)
				disp = text.replace(/\n/g, "<br>")
				tag = "<div id='"+@_objectID+"_text' style='position:absolute;z-index:1;overflow:hidden;'>"+disp+"</div>"
				
			x = 0
			y = 0
			
		@_editable = editable
		
		if ($(@_viewSelector+"_text").length)
			$(@_viewSelector+"_text").remove()
		
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_text").keypress (event)=>
			if (@action?)
				@action(event.which)
			
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
		
		$(@_viewSelector+"_text").width(@_frame.size.width)
		$(@_viewSelector+"_text").height(@_frame.size.height)
		
	setDidKeyPressEvent:(@action)->

	setFocus:(@_focus)->
		if (!$(@_viewSelector+"_text").length)
			return
		if (@_focus == true)
			$(@_viewSelector+"_text").focus()
		else
			$(@_viewSelector+"_text").blur()

	viewDidAppear: ->
		super()
		@setEditable(@_editable)
		$(@_viewSelector).css("vertical-align", "middle")
		$(@_viewSelector+"_text").width(@_frame.size.width)
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		@setPlaceholder(@_placeholder)
		$(@_viewSelector).css("overflow", "")


