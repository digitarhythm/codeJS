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
      #@_self.setHidden(true)
      @_self.setAlpha(0.2)
    else
      #@_self.setHidden(false)
      @_self.setAlpha(1.0)

  viewDidAppear:->
    super()
    @setEnable(@_enable)
    #$(@_viewSelector).unbind("click").bind "click", (event) =>
    $(@_viewSelector).on 'tap', (event)=>
      if (@action? && @_enable == true && @_userInteractionEnabled == true)
        @action(@_self)
        event.stopPropagation()
