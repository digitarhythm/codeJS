##########################################
# JSImageView - image control view class
# Coded by kouichi.sakazaki 2013.03.26
##########################################

class JSImageView extends JSView
	constructor:(@_image)->
		super()
		if (@_image._imagepath.string?)
			@_bgColor = JSColor("#f0f0f0")
			@setImage(@_image)

	setImage:(@_image)->
		img = "<img id='"+@_objectID+"_image' src='"+@_image._imagepath.string+"'>"
		if ($(@_viewSelector).length)
			if ($(@_viewSelector+"_image").length)
				$(@_viewSelector+"_image").remove()
			$(@_viewSelector).append(img)
		else
			@_div = @_div.replace(/<!--null-->/, img+"<!--null-->")
		@_self.setClipToBounds(true)
		
	setFrame:(frame)->
		super(frame)
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
		@setCornerRadius(@_cornerRadius)
		
	setClipToBounds:->
		@_clipToBounds = true