##########################################
# JSControl - User action control class
# Coded by kouichi.sakazaki 2013.03.29
##########################################

class JSControl extends JSView
	constructor:(frame)->
		super(frame)
		@_enable = true
	
	viewDidAppear:->
		super()
		$(@_viewSelector).unbind("click").bind "click", (event) =>
			if (@action?)
				if (@_enable == true)
					@action(@_self)
				event.stopPropagation()

	addTarget: (@action) ->
	
	setEnable:(@_enable)->
		if (@_enable == false)
			@_self.setAlpha(0.0)
		else
			@_self.setAlpha(1.0)
	