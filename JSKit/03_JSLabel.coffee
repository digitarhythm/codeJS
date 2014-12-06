#*****************************************
# JSLabel - One line text object
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSLabel extends JSView
    constructor: (frame = JSRectMake(0, 0, 120, 24)) ->
        super(frame)
        @_textSize = 10 
        @_textColor = JSColor("black")
        @_bgColor = JSColor("#f0f0f0")
        @_textAlignment = "JSTextAlignmentCenter"
        @_text = "Label"
        
    setText: (@_text) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).html(@_text)

    setTextSize: (@_textSize) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("font-size", @_textSize+"pt")

    setTextColor: (@_textColor) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("color", @_textColor)
        
    setTextAlignment: (@_textAlignment) ->
        switch @_textAlignment
            when "JSTextAlignmentCenter"
                $(@_viewSelector).css("text-align", "center")
            when "JSTextAlignmentLeft"
                $(@_viewSelector).css("text-align", "left")
            when "JSTextAlignmentRight"
                $(@_viewSelector).css("text-align", "right")
            else
                $(@_viewSelector).css("text-align", "center")
    
    setFrame:(frame)->
        super(frame)
        $(@_viewSelector).width(frame.size.width)
        $(@_viewSelector).height(frame.size.height)
    
    viewDidAppear: ->
        super()
        $(@_viewSelector).width(@_frame.size.width)
        $(@_viewSelector).css("vertical-align", "middle")
        $(@_viewSelector).css("line-height",@_frame.size.height+"px")
        @setText(@_text)
        @setTextSize(@_textSize)
        @setTextColor(@_textColor)
        @setTextAlignment(@_textAlignment)

