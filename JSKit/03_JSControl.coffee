#*****************************************
# JSControl - User action control class
# Coded by kouichi.sakazaki 2013.03.29
#*****************************************

class JSControl extends JSView
    constructor:(frame)->
        super(frame)
        @_enable = true

    addTarget: (@action) ->

    setEnable:(@_enable)->
        if (@_enable == false)
            @_self.setAlpha(0.2)
        else
            @_self.setAlpha(1.0)

    viewDidAppear:->
        super()
        @setEnable(@_enable)
        $(@_viewSelector).on 'click', (event)=>
            if (@action? && @_enable == true && @_userInteractionEnabled == true)
                event.stopPropagation()
                @action(@_self)
