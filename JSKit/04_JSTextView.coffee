#*****************************************
# JSTextView - User Interactive Text View
# Coded by kouichi.sakazaki 2013.03.26
#*****************************************

class JSTextView extends JSScrollView
	constructor: (frame) ->
		super(frame)
		@_editable = true
		@_textSize = 8 
		@_textColor = JSColor("black")
		@_bgColor = JSColor("white")
		@_borderColor = JSColor("clearColor")
		@_borderWidth = 0
		@_textAlignment = "JSTextAlignmentLeft"
		@_text = ""
		@_writingMode = 0
		@_lineHeight = 1.0
		@_fontFamily = "gothic"
		
	setWritingMode:(@_writingMode)->
		@_editable = false
		@setEditable(@_editable)

	getText:->
		if (@_editable == true)
			text = $(@_viewSelector+"_textarea").val()
		else
			text = @_text
		
		return text

	setText:(text)->
		@_text = text.replace(/<br>/g, "\n")
		if ($(@_viewSelector+"_textarea").length)
			if (@_writingMode == 0)
				writingmode = "horizontal-tb"
			else
				writingmode = "vertical-rl"
			
			$(@_viewSelector+"_textarea").css("-webkit-writing-mode", writingmode)
			
			if (@_editable == true)
				$(@_viewSelector+"_textarea").val(@_text)
			else
				disp = @_text.replace(/\n/g, "<br>")
				$(@_viewSelector+"_textarea").html(disp)
		
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
		
	setEditable:(editable)->
		if (!$(@_viewSelector).length)
			@_editable = editable
			return
		
		if (editable == true) # 編集可能モード
			
			if (@_editable == true) # モード変更前が編集可能モード
				
				if (!$(@_viewSelector+"_textarea").length)
					tag = "<textarea id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'>"+@_text+"</textarea>"
				else
					@_text = $(@_viewSelector+"_textarea").val()
					return
			
			else # モード変更前が編集不可モード
				
				tag = "<textarea id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'>"+@_text+"</textarea>"
				
			x = -2
			y = -2
			
		else # 編集不可モード
			
			if (@_editable == true) # モード変更前が編集可能モード
				
				@_text = $(@_viewSelector+"_textarea").val()
				text = JSEscape(@_text)
				disp = text.replace(/\n/g, "<br>")
				tag = "<div id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'>"+disp+"</div>"
			
			else # モード変更前が編集不可モード
				text = JSEscape(@_text)
				disp = text.replace(/\n/g, "<br>")
				tag = "<div id='"+@_objectID+"_textarea' style='position:absolute;overflow:auto;word-break:break-all;z-index:1;'>"+disp+"</div>"
				
			x = 0
			y = 0
		
		@_editable = editable
		
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").remove()
		$(@_viewSelector).append(tag)
		if (@_writingMode == 0)
			writingmode = "horizontal-tb"
		else
			writingmode = "vertical-rl"
		$(@_viewSelector+"_textarea").css("-webkit-writing-mode", writingmode)
		$(@_viewSelector+"_textarea").css("background-color", JSColor("clearColor"))
		$(@_viewSelector+"_textarea").css("border", "none")
		if (@_editable == true)
			$(@_viewSelector+"_textarea").unbind("click").bind "click", (event) =>
				event.stopPropagation()
			$(@_viewSelector+"_textarea").bind "change", =>
				@_text = $(@_viewSelector+"_textarea").val()
			
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		$(@_viewSelector+"_textarea").css("left", x)
		$(@_viewSelector+"_textarea").css("top", y)
		
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
	
	setTextLineHeight:(@_lineHeight)->
		if ($(@_viewSelector+"_textarea").length)
			$(@_viewSelector+"_textarea").css("line-height", @_lineHeight)
	
	setTextFontFamily:(@_fontFamily)->
		if ($(@_viewSelector+"_textarea").length)
			switch @_fontFamily
				when "mincho"
					JSLog("mincho")
					$(@_viewSelector+"_textarea").css("font-family", "'Hiragino Mincho ProN', serif;")
				when "gothic"
					JSLog("gothic")
					$(@_viewSelector+"_textarea").css("font-family", "'Hiragino Maru Gothic Pro W4', 'Hiragino Maru Gothic Pro', 'sans-serif';");

	viewDidAppear: ->
		super()
		@setEditable(@_editable)
		@setTextSize(@_textSize)
		@setTextColor(@_textColor)
		@setTextAlignment(@_textAlignment)
		@setTextLineHeight(@_lineHeight)
		@setTextFontFamily(@_fontFamily)
		#$(@_viewSelector+"_textarea").width(@_frame.size.width)
		#$(@_viewSelector+"_textarea").height(@_frame.size.height)
		if (@_editable == true)
			$(@_viewSelector+"_textarea").unbind("click").bind "click", (event) =>
				event.stopPropagation()


