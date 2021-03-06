#*****************************************
# JSScrollView - Scroll control class
# Coded by Hajime Oh-yake 2013.03.29
#*****************************************

class JSScrollView extends JSView
    constructor:(frame)->
        super(frame)
        @_frame.size.width
        @_scroll = false

    destructor:->
        super()

    setScroll:(@_scroll)->
        if (@_scroll == true)
            $(@_viewSelector).css("overflow", "auto")
            $(@_viewSelector).css("-webkit-overflow-scrolling", "touch")
        else
            @setClipToBounds(@_clipToBounds)

    viewDidAppear:->
        super()
        @setScroll(@_scroll)

    animateWithDuration:(duration, animations, completion = null)=>
        super(duration, animations, completion)
