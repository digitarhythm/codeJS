##########################################
# JSImageView - image control view class
# Coded by kouichi.sakazaki 2013.03.26
##########################################

class JSImageView extends JSView
	constructor:(frame)->
		super(frame)
		@_userInteractionEnabled = false
		@_bgColor = JSColor("clearColor")

	setImage:(@_image)->
		if (@_image?)
			img = "<img id='"+@_objectID+"_image' src='"+@_image._imagepath+"'>"
			if ($(@_viewSelector).length)
				if ($(@_viewSelector+"_image").length)
					$(@_viewSelector+"_image").remove()
				$(@_viewSelector).append(img)
				@setFrame(@_frame)
			else
				@_div = @_div.replace(/<!--null-->/, img+"<!--null-->")
			@_self.setClipToBounds(true)
		else
			if ($(@_viewSelector+"_image").length)
				$(@_viewSelector+"_image").remove()
		
	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_image").length)
			$(@_viewSelector+"_image").width(frame.size.width)
			$(@_viewSelector+"_image").height(frame.size.height)

	setCornerRadius:(radius)->
		super(radius)
		$(@_viewSelector+"_image").css("border-radius", radius)
		$(@_viewSelector+"_image").css("-webkit-border-radius", radius)
		$(@_viewSelector+"_image").css("-moz-border-radius", radius)
		
	viewDidAppear:->
		super()
		$(@_viewSelector+"_image").css("position", "absolute")
		$(@_viewSelector).css("z-index", "1")
		$(@_viewSelector+"_image").css("z-index", "1")
		@setCornerRadius(@_cornerRadius)