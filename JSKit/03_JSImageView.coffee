#*****************************************
# JSImageView - image control view class
# Coded by Hajime Oh-yake 2013.03.26
#*****************************************

class JSImageView extends JSView
    constructor:(frame)->
        super(frame)
        @_userInteractionEnabled = false
        @_bgColor = JSColor("clearColor")
        @_clipToBounds = true
        @_contentMode = "JSViewContentModeNormal"
        @_image = undefined

    setImage:(@_image)->
        if (@_image?)
            img = "<img id='"+@_objectID+"_image' src='"+@_image._imagepath+"' style='position:absolute;z-index:1;left:0px;top:0px;width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;'>"
            if ($(@_viewSelector).length)
                if ($(@_viewSelector+"_image").length)
                    $(@_viewSelector+"_image").remove()
                $(@_viewSelector).css("opacity", @_alpha)
                $(@_viewSelector).append(img)
                @setContentMode(@_contentMode)
            else
                @_div = @_div.replace(/<!--null-->/, img+"<!--null-->")
        else
            if ($(@_viewSelector+"_image").length)
                $(@_viewSelector+"_image").remove()
            $(@_viewSelector).css("opacity", "0.0")

    setCornerRadius:(radius)->
        super(radius)
        $(@_viewSelector+"_image").css("border-radius", radius)
        $(@_viewSelector+"_image").css("-webkit-border-radius", radius)
        $(@_viewSelector+"_image").css("-moz-border-radius", radius)

    setContentMode:(@_contentMode)->
        if ($(@_viewSelector).length && $(@_viewSelector+"_image").length)
            switch @_contentMode
                when "JSViewContentModeScaleAspectFit"
                    $(@_viewSelector).imgLiquid(fill: false)
                when "JSViewContentModeScaleAspectFill"
                    $(@_viewSelector).imgLiquid()

    viewDidAppear:->
        super()
        @setCornerRadius(@_cornerRadius)
        @setImage(@_image)
        @setContentMode(@_contentMode)

