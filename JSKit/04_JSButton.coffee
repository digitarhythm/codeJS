#*****************************************
# JSButton - Button Object
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSButton extends JSControl
	constructor:(frame = JSRectMake(4, 4, 64, 24))->
		super(frame)
		@_borderColor = JSColor("clearColor")
		@_bgColor = JSColor("clearColor")
		@_buttonTitle = "Button"
		@_style = "JSFormButtonStyleNormal"
		@_textSize = 8
		@delegate = null
		
	setButtonTitle:(title)->
		@_buttonTitle = title
		if ($(@_viewSelector+"_button").length)
			$(@_viewSelector+"_button").val(@_buttonTitle)
		
	setTextSize:(@_textSize)->
		$(@_viewSelector+"_button").css('font-size', @_textSize+'pt')
		
	setStyle:(@_style)->
		if ($(@_viewSelector+"_button").length)
			@viewDidAppear()
			
	setFrame:(frame)->
		super(frame)
		switch @_style
			when "JSFormButtonStyleNormal"
				w = frame.size.width - 16
				h = frame.size.height - 8
				$(@_viewSelector+"_button").width(w+"px")
				$(@_viewSelector+"_button").height(h+"px")
			when "JSFormButtonStyleImageUpload"
				w = @_frame.size.width
				$(@_viewSelector+"_button").width(w+"px")

	viewDidAppear:->
		super()
		if ($(@_viewSelector+"_button").length)
			$(@_viewSelector+"_button").remove()
		if ($(@_viewSelector+"_pack").length)
			$(@_viewSelector+"_pack").remove()
		tag = ""
		if (@_style == "JSFormButtonStyleNormal")
			w = @_frame.size.width - 16
			h = @_frame.size.height - 9
			tag += "<input type='submit' id='"+@_objectID+"_button' style='position:absolute;z-index:1;' value='"+@_buttonTitle+"' />"
		else if (@_style == "JSFormButtonStyleImageUpload")
			w = @_frame.size.width - 16
			h = @_frame.size.height - 9
			tag += "<div id=\""+@_objectID+"_pack\">"
			tag += "<input id=\""+@_objectID+"_file\" type=\"file\" name=\""+@_objectID+"_file\" style=\"display:none;\">"
			tag += "<input type=\"submit\" id=\""+@_objectID+"_button\" style=\"width:"+w+"px; height:"+h+"px; position:absolute;z-index:1;\" value=\"Upload\" onClick=\"$('#"+@_objectID+"_file').click();\" />"
			tag += "</div>"
		$(@_viewSelector).append(tag)
		if (@_style == "JSFormButtonStyleImageUpload")
			$(@_viewSelector+"_file").change =>
				$(@_viewSelector+"_file").upload "syslibs/library.php",
					mode: "uploadfile"
					key: @_objectID+"_file"
				, (res) =>
					$(@_viewSelector+"_file").val("")
					$.post "syslibs/library.php",
						mode:"createThumbnail"
						path:"Media/Picture"
					, =>
						if (@delegate?)
							@delegate.didImageUpload(res)
				, "json"
		$(@_viewSelector).css("overflow", "visible")
		$(@_viewSelector+"_button").css("overflow", "hidden")
		$(@_viewSelector+"_button").css("position", "absolute")
		$(@_viewSelector+"_button").css("background-color", "transparent")
		$(@_viewSelector+"_button").width(w+"px")
		$(@_viewSelector+"_button").height(h+"px")
		$(@_viewSelector+"_button").css("font-size", @_textSize+"pt")
		$(@_viewSelector+"_button").button()
