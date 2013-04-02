##########################################
# JSControl - User action control class
# Coded by kouichi.sakazaki 2013.03.29
##########################################

class JSControl extends JSView
	constructor:(frame)->
		super(frame)
	
	viewDidAppear:->
		super()
		$(@_viewSelector).unbind("click").bind "click", (event) =>
			if (@action?)
				@action(@_self)
				event.stopPropagation()

	addTarget: (@action) ->
	