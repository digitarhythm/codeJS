##########################################
# JSControl - User action control class
# Coded by kouichi.sakazaki 2013.03.29
##########################################

class JSControl extends JSView
	constructor:(frame)->
		super(frame)
		@_enable = true
	
	addTarget: (@action) ->
	
	setEnable:(@_enable)->
		if (@_enable == false)
			@_self.setHidden(true)
		else
			@_self.setHidden(false)

	viewDidAppear:->
		super()
		@setEnable(@_enable)
		$(@_viewSelector).unbind("click").bind "click", (event) =>
			if (@action? && @_enable == true)
					@action(@_self)
				event.stopPropagation()