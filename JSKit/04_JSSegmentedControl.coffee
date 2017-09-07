#*****************************************
# JSSegmentedControl - radio switch parts class
# Coded by kouichi.sakazaki 2013.11.05
#*****************************************

class JSSegmentedControl extends JSControl
    constructor:(@_dataarray)->
        super(JSRectMake(0, 0, 120, 32))
        @_bgColor = JSColor("clearColor")
        @_textSize = 12
        @_selectedSegmentIndex = 0

    setValue:(@_selectedSegmentIndex)->
        if ($(@_viewSelector+"_radio").length)
            if (@_selectedSegmentIndex == 0)
                @addSegmentTag()

    getValue:->
        return @_selectedSegmentIndex

    setTextSize:(@_textSize)->

    addSegmentTag:->
        button_w = Math.floor((@_frame.size.width - 128) / (@_dataarray.length + 1)) + 4
        button_h = @_frame.size.height - 32
        tag = ""
        tag += "<form id='#{@_objectID}_radio'>"
        for i in [1..@_dataarray.length]
            if (i == @_selectedSegmentIndex)
                check = "checked"
            else
                check = ""
            tag += "<label for='#{@_objectID}-radio-#{i}' style='position:absolite;width:#{button_w}px;height:#{button_h}px;line-height:#{button_h}px;'>#{@_dataarray[i-1]}</label>"
            tag += "<input type='radio' name='#{@_objectID}_radio' id='#{@_objectID}-radio-#{i}' style='position:absolite;width:#{button_w}px;height:#{button_h}px;padding:8px;' value='#{i}' #{check}>"
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
