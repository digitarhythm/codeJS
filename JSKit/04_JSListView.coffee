#*****************************************
# JSListView list view manage class
# Coded by Hajime Oh-yake 2013.04.02
#*****************************************

class JSListView extends JSScrollView
    constructor:(frame)->
        super(frame)
        @_listData = null
        @_orglist = null
        @_clickaction = null
        @_dblclickaction = null
        @_style = "JSListStyleStandard"
        @_textSize = 12
        @_select = -1
        @_clipToBounds = true
        #@_scroll = true
        @_delegate = @

    setFrame:(frame)->
        super(frame)
        if ($(@_viewSelector+"_select").length)
            $(@_viewSelector+"_select").width(frame.size.width)
            $(@_viewSelector+"_select").height(frame.size.height)

    setListData:(list)->
        @_orglist = list
        switch @_style
            when "JSListStyleStandard", "JSListStyleDropdown"
                if (@_style=="JSListStyleStandard")
                    size = 2
                    @_listData = list
                else
                    size = 1
                    if (!list?)
                        return
                    @_listData = new Array()
                    for item in list
                        @_listData.push(item)

                @_tag = "<select id='"+@_objectID+"_select' size='"+size+"' style='width:"+(@_frame.size.width)+"px;height:"+(@_frame.size.height)+"px;z-index:1;'>"
                if (!@_listData?)
                    @_listData = new Array()
                for i in [0...@_listData.length]
                    value = @_listData[i]
                    disp = JSEscape(value)
                    @_tag += "<option id='"+i+"' value='"+i+"'>"+disp+"</option>"
                @_tag += "</select>"
                if ($(@_viewSelector+"_select").length)
                    $(@_viewSelector+"_select").remove()
                $(@_viewSelector).append(@_tag)

                $(@_viewSelector+"_select").css("background-color", "clearColor")
                $(@_viewSelector+"_select").css("border", "0px transparent")
                $(@_viewSelector+"_select").css("font-size", @_textSize)

                if (@_style=="JSListStyleStandard")
                    #$(@_viewSelector+"_select").click (e) =>
                    $(@_viewSelector+"_select").on 'click', (e) =>
                        e.stopPropagation()
                        @_select = $(@_viewSelector+"_select option:selected").val()
                        if (@_clickaction? && @_select?)
                            @_clickaction(@_select)
                    #$(@_viewSelector+"_select").dblclick (e) =>
                    $(@_viewSelector+"_select").on "dblclick", (e) =>
                        e.stopPropagation()
                        @_select = $(@_viewSelector+"_select option:selected").val()
                        if (@_dblclickaction? && @_select?)
                            @_dblclickaction(@_select)
                else
                    $(@_viewSelector+"_select").change (e) =>
                        e.stopPropagation()
                        @_select = $(@_viewSelector+"_select option:selected").val()
                        if (@_clickaction? && @_select?)
                            @_clickaction(@_select)

            when "JSListStyleSortable"
                @_tag = "<table style='width:100%;'><tbody id='"+@_objectID+"_select'>"
                if (!list?)
                    return
                @_listData = new Array()
                for item in list
                    @_listData.push(item)
                for i in [0...@_listData.length]
                    disp = JSEscape(@_listData[i])
                    @_tag += "<tr id='"+i+"' class='ui-state-default' style='width:100%;z-index:1;'><td>"+disp+"</td></tr>"
                @_tag += "</tbody></table>"
                if ($(@_viewSelector+"_select").length)
                    $(@_viewSelector+"_select").remove()
                $(@_viewSelector).append(@_tag)

                $(@_viewSelector+"_select").sortable
                    placeholder: "ui-sortable-placeholder"
                    distance: 3
                    opacity:0.8
                    scroll: false
                    update: (event, ui)=>
                        @sortReflection()
                        if (typeof @_delegate.sortUpdate == 'function')
                            @_delegate.sortUpdate(event, ui)

                $(@_viewSelector+"_select").disableSelection()

                $(@_viewSelector+"_select").css("background-color", "transparent")
                $(@_viewSelector+"_select").css("border", "0px transparent")
                $(@_viewSelector+"_select").css("font-size", (@_textSize-4)+"pt")

        $(@_viewSelector+"_select").width(@_frame.size.width+"px")
        $(@_viewSelector+"_select").height(@_frame.size.height+"px")

    count:->
        return @_listData.length

    objectAtIndex:(index)->
        return @_listData[index]

    indexOfObject:(target)->
        num = @_listData.indexOf(target)
        return num

    getSelect:->
        return @_select

    setSelect:(@_select)->
        $(@_viewSelector+"_select").val(@_select)

    sortReflection:->
        if (@_style == "JSListStyleSortable")
            arr = $(@_viewSelector+"_select").sortable("toArray")
            ret = []
            for key, i in arr
                ret[i] = @_orglist[key]
            @_listData = ret

    setTextSize:(@_textSize)->
        if (@_listData?)
            @setListData(@_listData)

    addTarget:(action, tap = 1)->
        if (tap == 1)
            @_clickaction = action
        else
            @_dblclickaction = action

    setStyle:(@_style)->
        @setListData(@_listData)

    reload:->
        @setListData(@_listData)

    viewDidAppear:->
        super()
        @setListData(@_listData)
        @setSelect(@_select)
