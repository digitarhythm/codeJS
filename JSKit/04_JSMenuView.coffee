#*****************************************
# JSMenuView - Menu control class
# Coded by Hajime Oh-yake 2013.04.04
#*****************************************

class JSMenuView extends JSScrollView
    constructor:(frame = JSRectMake(0, 0, 200, 0))->
        super(frame)
        @_textSize = 10
        @_bgColor = JSColor("clearColor")
        @_clipToBounds = false
        @_containment = false

    addTarget:(@_action)->

    setTextSize:(@_textSize)->
        addMenuItem:(@_menuitem)

    addMenuItem:(@_menuitem)->
        if (!@_menuitem?)
            return

        if (!$(@_viewSelector).length)
            return

        @_div = "<ul id='"+@_objectID+"_menu' style='z-index:1;'><!--menuitem--></ul>"
        menustr = ""
        for disp in @_menuitem
            menustr += "<li><div>"+disp+"</div></li>"
        @_div = @_div.replace(/<!--menuitem-->/, menustr)

        if ($(@_viewSelector+"_menu").length)
            $(@_viewSelector+"_menu").remove()

        $(@_viewSelector).append(@_div)
        $(@_viewSelector+"_menu").css("left", "0px")
        $(@_viewSelector+"_menu").css("top", "0px")
        #$(@_viewSelector+"_menu").css("width", @_frame.size.width+"px")
        #$(@_viewSelector+"_menu").css("height", (@_frame.size.height * @_menuitem.length)+"px")
        $(@_viewSelector+"_menu").css("position", "absolute")
        $(@_viewSelector+"_menu").css("overflow", "visible")
        $(@_viewSelector+"_menu").css("font-size", @_textSize+"pt")
        #$(@_viewSelector+"_menu").css("background-color", @_backgroundColor)
        $(@_viewSelector+"_menu").menu
            select: (event, ui) =>
                if (@_userInteractionEnabled == false)
                    return
                item = ui.item.text()
                @selectMenuItem(item)
                @closeMenu()
            classes:
                "ui-menu": "highlight"
            position:
                my: "left top"
                at: "right-5 top+5"

    selectMenuItem:(item)->
        if (@_action?)
            for o, i in @_menuitem
                if (o == item)
                    ret = i
                    break
            @_action(ret)

    closeMenu:->
        $(@_viewSelector+"_menu").remove()
        event.stopPropagation()


    viewDidAppear:->
        super()
        if (!$(@_viewSelector+"_menu").length)
            @addMenuItem(@_menuitem)
