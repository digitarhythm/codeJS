#*****************************************
# JSSegmentedControl - radio switch parts class
# Coded by kouichi.sakazaki 2013.11.05
#*****************************************

class JSSegmentedControl extends JSControl
    constructor:(@_dataarray)->
        super(JSRectMake(0, 0, 120, 32))
        @_bgColor = JSColor("clearColor")
        @_textSize = 10
        @_selectedSegmentIndex = 0

    setValue:(@_selectedSegmentIndex)->
        if ($(@_viewSelector+"_radio").length)
            @addSegmentTag()

    getValue:->
        return @_selectedSegmentIndex

    setTextSize:(@_textSize)->
        if ($(@_viewSelector+"_radio").length)
            @addSegmentTag()

    addSegmentTag:->
        button_w = Math.floor((@_frame.size.width) / (@_dataarray.length + 1))
        JSLog("button_w=%@", button_w)
        button_h = @_frame.size.height
        tag = ""
        tag += "<form id='#{@_objectID}_radio' style='width:#{@_frame.size.width}px;'>"
        for i in [1..@_dataarray.length]
            if (i == @_selectedSegmentIndex)
                check = "checked"
            else
                check = ""
            tag += "<label for='#{@_objectID}-radio-#{i}' style='width:#{button_w}px;height:#{button_h}px;line-height:#{button_h}px;font-size:#{@_textSize}pt;'>#{@_dataarray[i-1]}</label>"
            tag += "<input type='radio' name='#{@_objectID}_radio' id='#{@_objectID}-radio-#{i}' value='#{i}' #{check}>"
        tag += "</form>"

        if ($(@_viewSelector+"_radio").length)
            $(@_viewSelector+"_radio").remove()
        $(@_viewSelector).append(tag)
        $("input[name='#{@_objectID}_radio']").checkboxradio
            icon: false
            classes:
                "ui-checkboxradio": "highlight"
        $(@_viewSelector+"_radio").on 'click', =>
            select = parseInt($(@_viewSelector+"_radio input:radio:checked").val())
            select2 = parseInt(@_selectedSegmentIndex)
            if (select? && select != select2)
                @_selectedSegmentIndex = select

    viewDidAppear:->
        super()
        if (!@_dataarray?)
            return
        @addSegmentTag()
        @setValue(@_selectedSegmentIndex)
