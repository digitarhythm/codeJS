##########################################
# JSButton - Button Object
# Coded by kouichi.sakazaki 2013.03.25
##########################################

class JSButton extends JSControl
	constructor:(frame = JSRectMake(4, 4, 64, 24))->
		super(frame)
		@_borderColor = JSColor("clearColor")
		@_bgColor = JSColor("clearColor")
		@_buttonTitle = "Button"
		@_type = "JSFormButtonTypeNormal"
		@_textSize = 8
		
	setButtonTitle:(title)->
		@_buttonTitle = title
		if ($(@_viewSelector+"_button").length)
			$(@_viewSelector+"_button").val(@_buttonTitle)
		
	setTextSize:(@_textSize)->
		$(@_viewSelector+"_button").css('font-size', @_textSize+'pt')
		
	setType:(@_type)->
		if ($(@_viewSelector+"_button").length)
			@viewDidAppear()
			
	setFrame:(frame)->
		super(frame)
		switch @_type
			when "JSFormButtonTypeNormal"
				w = frame.size.width - 16
				h = frame.size.height - 8
				$(@_viewSelector+"_button").width(w+"px")
				$(@_viewSelector+"_button").height(h+"px")
			when "JSFormButtonTypeFileSelect"
				w = @_frame.size.width
				$(@_viewSelector+"_button").width(w+"px")

	setAction:(@_fileuploadAction)->

	viewDidAppear:->
		super()
		if ($(@_viewSelector+"_button").length)
			$(@_viewSelector+"_button").remove()
		if (@_type == "JSFormButtonTypeNormal")
			tag = "<input type='submit' id='"+@_objectID+"_button' style='position:absolute;' value='"+@_buttonTitle+"' />"
			w = @_frame.size.width - 16
			h = @_frame.size.height - 8
		else if (@_type == "JSFormButtonTypeFileSelect")
			tag = "<input id='"+@_objectID+"_button' type='file' name='"+@_objectID+"_button' enctype='multipart/form-data' />"
			w = @_frame.size.width
			h = 18
		$(@_viewSelector).append(tag)
		if (@_type == "JSFormButtonTypeFileSelect")
			$(@_viewSelector+"_button").change =>
				$(@_viewSelector+"_button").upload "syslibs/library.php",
					mode: "uploadfile"
					key: @_objectID+"_button"
				, (res) =>
					$(@_viewSelector+"_button").val("")
					$.post "syslibs/library.php",
						mode:"createThumbnail"
						path:"Media/Picture"
					, =>
						if (@_fileuploadAction?)
							@_fileuploadAction(res)
				, "json"
		$(@_viewSelector).css("overflow", "visible")
		$(@_viewSelector+"_button").css("overflow", "hidden")
		$(@_viewSelector+"_button").css("position", "absolute")
		$(@_viewSelector+"_button").css("background-color", "transparent")
		$(@_viewSelector+"_button").width(w+"px")
		$(@_viewSelector+"_button").height(h+"px")
		$(@_viewSelector+"_button").css("font-size", @_textSize+"pt")
		$(@_viewSelector+"_button").button()
