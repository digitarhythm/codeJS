#*****************************************
# JSTableViewCell - tableCell base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableViewCell extends JSView
    constructor:->
        super()
        @_image = null
        @_imageview = null
        @_alpha = 1.0
        @_text = ""
        @_textColor = JSColor("black")
        @_textSize = 12
        @_textAlignment = "JSTextAlignmentLeft"
        @_bgColor = JSColor("clearColor")
        @_borderColor = JSColor("#d0d8e0")
        @_borderWidth = 1

        sidesize = @_frame.size.height
        @tag = "<div id='"+@_objectID+"_cell' style='position:absolute;left:0px;top:0px;width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;z-index:1; opacity:"+@_alpha+";'><div id='"+@_objectID+"_text' style='position:relative;left:"+@_frame.size.height+"px;top:0px;width:"+(@_frame.size.width-sidesize-4)+"px;height:"+@_frame.size.height+"px;display:table-cell;vertical-align:middle;'></div></div>"

    setText:(@_text)->
        if ($(@_viewSelector+"_text").length)
            $(@_viewSelector+"_text").html(@_text)

    setTextSize:(@_textSize)->
        if ($(@_viewSelector+"_text").length)
            $(@_viewSelector+"_text").css("font-size", @_textSize)

    setTextColor:(@_textColor)->
        if ($(@_viewSelector+"_text").length)
            $(@_viewSelector+"_text").css("color", @_textColor)

    setTextAlignment:(@_textAlignment)->
        switch @_textAlignment
            when "JSTextAlignmentLeft"
                $(@_viewSelector+"_text").css("text-align", "left")
            when "JSTextAlignmentCenter"
                $(@_viewSelector+"_text").css("text-align", "center")
            when "JSTextAlignmentRight"
                $(@_viewSelector+"_text").css("text-align", "right")

    setImage:(@_image)->
        if (!$(@_viewSelector+"_cell").length)
            return
        if (!@_image?)
            return
        if ($(@_viewSelector+"_image").length)
            $(@_viewSelector+"_image").remove()
        sidesize = @_frame.size.height
        $(@_viewSelector+"_cell").append("<img id='"+@_objectID+"_image' border='0' src='"+@_image._imagepath+"' style='position:absolute;left:0px;top:0px;width:"+sidesize+"px;height:"+sidesize+"px;'>")

    setFrame:(frame)->
        super(frame)
        if ($(@_viewSelector+"_cell").length)
            $(@_viewSelector+"_cell").css("width", frame.size.width)
            $(@_viewSelector+"_cell").css("height", frame.size.height)
            $(@_viewSelector+"_image").css("width", frame.size.height)
            $(@_viewSelector+"_image").css("height", frame.size.height)
            $(@_viewSelector+"_text").css("left", frame.size.height)
            $(@_viewSelector+"_text").css("width", frame.size.width-frame.size.height)
            $(@_viewSelector+"_text").css("height", frame.size.height)

    viewDidAppear:->
        super()
        @_frame.origin.x = 1
        $(@_viewSelector).append(@tag)
        @setFrame(@_frame)
        @setAlpha(@_alpha)
        @setText(@_text)
        @setTextColor(@_textColor)
        @setTextSize(@_textSize)
        @setTextAlignment(@_textAlignment)
        @setImage(@_image)
        $(@_viewSelector).on 'tap', (event)=>
            if (typeof @delegate.didSelectRowAtIndexPath == 'function')
                @_tableview.deselectRowAtIndexPath()
                @setBackgroundColor(JSColor("#87cefa"))
                @delegate.didSelectRowAtIndexPath(@_cellnum, event)

