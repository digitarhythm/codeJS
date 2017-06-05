#*****************************************
# JSView - base class of all view object
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSView extends JSResponder
    constructor: (@_frame = JSRectMake(0, 0, 320, 240))->
        super()
        @_parent = null
        @_viewSelector = "#"+@_objectID
        @_bgColor = JSColor("#c0c0c0")
        @_alpha = 1.0
        @_cornerRadius = 0
        @_borderColor = JSColor("clearColor")
        @_borderWidth = 0
        @_clipToBounds = false
        @_draggable = false
        @_resizable = false
        @_containment = false
        @_div = "<div id=\"" + @_objectID + "\" style='position:absolute;z-index:1;'><!--null--></div>"
        @_ignoreDraggable = []
        @_objlist = new Array()
        @_shadow = false
        @_userInteractionEnabled = true
        @_axis = false
        @_touched = false
        @_hidden = false

    destructor:->

    addSubview: (object) ->
        if (!object?)
            return

        @_objlist.push(object)
        object._parent = @_self

        if ($(@_viewSelector).length)
            $(@_viewSelector).append(object._div)
            object.setDraggable(object._draggable, object._axis, object._dragopacity)
            object.setResizable(object._resizable, object._resizeAction, object._resizeopacity)
            object.viewDidAppear()

    setFrame: (@_frame) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("width", @_frame.size.width+"px")
            $(@_viewSelector).css("height", @_frame.size.height+"px")
            $(@_viewSelector).css("left", @_frame.origin.x+"px")
            $(@_viewSelector).css("top", @_frame.origin.y+"px")

    setBackgroundColor: (@_bgColor) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("background-color", @_bgColor)

    setAlpha: (@_alpha, flag = false) ->
        if (@_alpha < 0 or @_alpha > 1)
            return
        if ($(@_viewSelector).length)
            ret = @_bgColor.match(/^(#)(..)(..)(..)$/)
            if (ret? && ret[1] == "#" && flag)
                r = String(parseInt(ret[2], 16))
                g = String(parseInt(ret[3], 16))
                b = String(parseInt(ret[4], 16))
                col = 'rgba('+r+', '+g+', '+b+', '+@_alpha+')'
                $(@_viewSelector).css("background-color", col)
            else
                $(@_viewSelector).css("opacity", @_alpha)

    setCornerRadius: (@_cornerRadius) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("-webkit-border-radius", @_cornerRadius+"px")
            $(@_viewSelector).css("-moz-border-radius", @_cornerRadius+"px")
            $(@_viewSelector).css("border-radius", @_cornerRadius+"px")

    setBorderColor: (@_borderColor) ->
        if ($(@_viewSelector).length)
            $(@_viewSelector).css("border-color", @_borderColor)
            $(@_viewSelector).css("border-style", "solid")
            $(@_viewSelector).css("border-width", @_borderWidth)

    setBorderWidth: (@_borderWidth) ->
        $(@_viewSelector).css("border-width", @_borderWidth)
        $(@_viewSelector).css("border-style", "solid")
        $(@_viewSelector).css("border-width", @_borderWidth)

    setClipToBounds: (@_clipToBounds) ->
        if ($(@_viewSelector).length)
            if (@_clipToBounds == true)
                $(@_viewSelector).css("overflow", "hidden")
            else
                $(@_viewSelector).css("overflow", "normal")

    setUserInteractionEnabled:(@_userInteractionEnabled)->

    disableDragObject:(object)->
        if ($(@_viewSelector).length)
            $(@_viewSelector).draggable('option', 'cancel', object._viewSelector)

    setDraggable: (@_draggable, @_axis = false, @_dragopacity = 0.5) ->
        if (@_parent?)
            containment = @_parent._containment
        else
            containment = false

        if (!$(@_viewSelector).length)
            return

        if (@_draggable == true)
            $(@_viewSelector).css("cursor", "pointer")
            if (containment == true)
                $(@_viewSelector).draggable
                    containment:"parent"
                    axis: @_axis
                    opacity: @_dragopacity
                    disabled: false
            else
                $(@_viewSelector).draggable
                    disabled: false
                $(@_viewSelector).draggable("destroy")
                $(@_viewSelector).draggable
                    opacity:@_dragopacity
                    axis: @_axis
                    disabled: false
        else
            $(@_viewSelector).css("cursor", "auto")
            $(@_viewSelector).draggable({disabled: true})

    setResizable: (@_resizable, @_resizeAction = null, @_resizeopacity = 0.5, minWidth = 0, minHeight = 0, maxWidth = 16777216, maxHeight = 16777216) ->
        if (@_parent?)
            containment = @_parent._containment
        else
            containment = false

        if (!$(@_viewSelector).length)
            return

        if (@_resizable == true)
            if (containment == true)
                $(@_viewSelector).resizable
                    containment:"parent"
                    minWidth:minWidth
                    minHeight:minHeight
                    maxWidth:maxWidth
                    maxHeight:maxHeight
                    resize: (event, ui) =>
                        frame = @_frame
                        frame.origin.x = $(@_viewSelector).css("left")
                        frame.origin.y = $(@_viewSelector).css("top")
                        frame.size.width = $(@_viewSelector).width()
                        frame.size.height = $(@_viewSelector).height()
                        @_self.setFrame(frame)
                        if (@_resizeAction?)
                            @_resizeAction()
            else
                $(@_viewSelector).resizable
                    opacity:@_resizeopacity
                    disabled: false
                $(@_viewSelector).resizable("destroy")
                $(@_viewSelector).resizable
                    minWidth:minWidth
                    minHeight:minHeight
                    maxWidth:maxWidth
                    maxHeight:maxHeight
                    opacity:@_resizeopacity
                    disabled: false
                    resize: (event, ui) =>
                        frame = @_self._frame
                        frame.size.width = $(@_viewSelector).width()
                        frame.size.height = $(@_viewSelector).height()
                        @_self.setFrame(frame)
                        @_resizeAction()

    setHidden:(@_hidden)->
        if ($(@_viewSelector).length)
            if (@_hidden == true)
                $(@_viewSelector).css("display", "none")
            else
                $(@_viewSelector).css("display", "inline-block")

    setContainment:(@_containment) ->
        for obj in @_objlist
            obj.setDraggable(obj._draggable, obj._axis, obj._dragopacity)

    bringSubviewToFront:(obj)->
        id = obj._objectID
        v = $('#' + id)
        v.appendTo(v.parent())

    removeFromSuperview:=>
        @destructor() if (typeof @destructor == 'function')
        return if (@_parent == null)
        t = -1
        i = 0
        for o in @_parent._objlist
            if (o._objectID == @_objectID)
                t = i
                break;
            i++
        if ( t >= 0)
            @_parent._objlist.splice(t, 1)
            $(@_viewSelector).remove()
            return null

    removeTapGesture:(tapnum)->
        switch tapnum
            when 1
                if (@_userInteractionEnabled == true)
                    $(@_viewSelector).unbind("click").bind "click", (event) =>
                        event.stopPropagation()
                else
                    @_tapAction = null
                    $(@_viewSelector).unbind("click")

            when 2
                if (@_userInteractionEnabled == true)
                    $(@_viewSelector).unbind("dblclick").bind "dblclick", (event) =>
                        event.stopPropagation()
                else
                    @_tapAction2 = null
                    $(@_viewSelector).unbind("dblclick")

    addTapGesture:(tapAction, tapnum = 1)=>
        if (tapnum == 1)
            @_tapAction = tapAction
        else if (tapnum == 2)
            @_tapAction2 = tapAction
        else
            return

        if (!$(@_viewSelector).length)
            return

        $(@_viewSelector).css("cursor", "pointer")
        if (tapnum == 1)
            $(@_viewSelector).unbind("tap")
            $(@_viewSelector).on 'tap', (e)=>
                if (@_tapAction? && @_userInteractionEnabled == true && @_alpha > 0.0 && @_hidden == false)
                    @_tapAction(@_self, e)
                    e.stopPropagation()

        if (tapnum == 2)
            $(@_viewSelector).unbind("doubletap")
            $(@_viewSelector).on 'doubletap', (e)=>
                if (@_tapAction2? && @_userInteractionEnabled == true && @_alpha > 0.0 && @_hidden == false)
                    @_tapAction2(@_self, e)
                    e.stopPropagation()

    animateWithDuration:(duration, animations, completion = undefined, flag = false)=>
        duration *= 1000
        animobj = {}
        for key, value of animations
            if (key == "alpha")
                key = "opacity"
            else if (key == "alpha2")
                ret = @_bgColor.match(/^(#)(..)(..)(..)$/)
                if (ret? && ret[1] == "#")
                    r = String(parseInt(ret[2], 16))
                    g = String(parseInt(ret[3], 16))
                    b = String(parseInt(ret[4], 16))
                    key = "background-color"
                    value = 'rgba('+r+', '+g+', '+b+', '+value+')'
            animobj[key] = value

        $(@_viewSelector).animate animobj, duration, =>
            for key, value of animobj
                switch key
                    when "top"
                        @_frame.origin.y = value
                    when "left"
                        @_frame.origin.x = value
                    when "opacity"
                        @_alpha = value
                    when "background-color"
                        @_bgColor = value
                    when "border-color"
                        @_borderColor = value
                    when "border-width"
                        @_borderWidth = value
                    when "width"
                        @_frame.size.width = value
                    when "height"
                        @_frame.size.height = value
            if (completion?)
                completion(@_self)

    setShadow:(@_shadow)->
        if (@_shadow == true)
            $(@_viewSelector).css("box-shadow", "2px 2px 10px rgba(0,0,0,0.4)")
        else
            $(@_viewSelector).css("box-shadow", "none")

    didBrowserResize:->
        for obj in @_objlist
            if (typeof obj.didBrowserResize == 'function')
                obj.didBrowserResize()

    viewDidAppear: ->
        @setHidden(@_hidden)
        @setFrame(@_frame)
        @setBackgroundColor(@_bgColor)
        @setCornerRadius(@_cornerRadius)
        @setAlpha(@_alpha)
        @setBorderColor(@_borderColor)
        @setBorderWidth(@_borderWidth)
        @setShadow(@_shadow)
        @setDraggable(@_draggable, @_axis, @_dragopacity)
        @setResizable(@_resizable, @_resizeAction, @_resizeopacity)
        @setClipToBounds(@_clipToBounds)

        @removeTapGesture(1)
        @removeTapGesture(2)
        if (@_tapAction?)
            @addTapGesture(@_tapAction)
        if (@_tapAction2?)
            @addTapGesture(@_tapAction2, 2)

        if (@_objlist.length > 0)
            for i in [0...objectNum(@_objlist)]
                o = @_objlist[i]
                if (!$(o._viewSelector).length)
                    $(@_viewSelector).append(o._div)
                    o.viewDidAppear()

        $(@_viewSelector).bind
            'touchstart mousedown':(event)=>
                if (@_editable == false && event?)
                    event.preventDefault()
                @touched = true
                if (typeof @touchesBegan == 'function')
                    if (isTouch() == true && event.changedTouches != undefined)
                        e = event.changedTouches[0]
                    else
                        e = event
                    @touchesBegan(e)
            'touchmove mousemove':(event)=>
                if (@_editable == false && event?)
                    event.preventDefault()
                if (@touched)
                    if (typeof @touchesMoved == 'function')
                        if (isTouch() == true && event.changedTouches != undefined)
                            e = event.changedTouches[0]
                        else
                            e = event
                        @touchesMoved(e)
            'touchend mouseup':(event)=>
                if (@_editable == false && event?)
                    event.preventDefault()
                @touched = false
                if (typeof @touchesEnded == 'function')
                    if (isTouch() == true && event.changedTouches != undefined)
                        e = event.changedTouches[0]
                    else
                        e = event
                    @touchesEnded(e)
            'touchcancel':(event)=>
                if (@_editable == false && event?)
                    event.preventDefault()
                @touched = false
                if (typeof @touchesCancelled == 'function')
                    if (isTouch() == true && event.changedTouches != undefined)
                        e = event.changedTouches[0]
                    else
                        e = event
                    @touchesCancelled(e)

