##########################################
# JSButton - Button Object
# Coded by kouichi.sakazaki 2013.03.25
##########################################

class JSButton extends JSControl
	constructor: (frame = JSRectMake(4, 4, 64, 24)) ->
		super(frame)
		@_borderColor = JSColor("clearColor")
		@_backgroundColor = JSColor("clearColor")
		@_buttonTitle = "Button"
		@_textSize = 8
		
	setButtonTitle: (@_buttonTitle) ->
		$(@_viewSelector+"_button").val(@_buttonTitle)
		
	setTextSize: (@_textSize) ->
		$(@_viewSelector+"_button").css('font-size', @_textSize+'pt')
		
	viewDidAppear: ->
		super()
		if ($(@_viewSelector+"_button").length)
			$(@_viewSelector+"_button").remove()
		@setBackgroundColor(JSColor("clearColor"))
		tag = "<input type='submit' id='"+@_objectID+"_button' style='position:absolute;' value='"+@_buttonTitle+"' />"
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_button").width(@_frame.size.width)
		$(@_viewSelector+"_button").height(@_frame.size.height)
		$(@_viewSelector+"_button").css("font-size", @_textSize)
		$(@_viewSelector+"_button").button()
