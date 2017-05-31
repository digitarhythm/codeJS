#*****************************************
# JSAlertView - Dialog control class
# Coded by kouichi.sakazaki 2013.04.25
#*****************************************

class JSAlertView extends JSView
    constructor:(@_title, @_message, @_param = undefined, @_passform = undefined)->
        super()
        @_bgColor = JSColor("clearColor")
        @_style = "JSAlertViewStyleDefault"
        @delegate = @
        @cancel = false
        @_closeEvent = undefined

    setAlertViewStyle:(@_style)->
        $("body").css({"font-size": "80%"})
        @_tag  = "<div id='"+@_objectID+"_form' title='"+@_title+"'>"
        @_tag += "<p class='validateTips' style='height:24px;'>"+@_message+"</p>"
        if (@_style == "JSAlertViewStylePlainTextInput" && @_param?)
            dialogHeight = 200+(64*@_param.length)
            @_tag += "<fieldset style='border:0px transparent dotted;'>"
            for i in [0...@_param.length]
                p = @_param[i]
                if (@_data?)
                    value = @_data[i]
                else
                    value = ""
                @_tag += "<label style='vertical-align:bottom; height:24px;'>"+p+"</labeL><br>"
                if (@_passform?)
                    if (@_passform.indexOf(i) < 0)
                        formtype = "text"
                    else
                        formtype = "password"
                addtag = "<input type='"+formtype+"' name='"+@_objectID+"_textfield_"+i+"' id='"+@_objectID+"_textfield_"+i+"' style='width:"+@_frame.size.width+"px;height:16px;font-size:10pt;' value='"+value+"' /><br><br>"
                @_tag += addtag
            @_tag += "</fieldset>"
        else
            dialogHeight = 200
        @_tag += "</div>"
        if ($(@_viewSelector+"_form").length)
            $(@_viewSelector+"_form").remove()
        $(@_viewSelector).append(@_tag)
        buttonhash =
            OK:=>
                if (@delegate? && typeof @delegate.clickedButtonAtIndex == "function")
                    switch @_style
                        when "JSAlertViewStylePlainTextInput"
                            arr = []
                            for i in [0...@_param.length]
                                t = $(@_viewSelector+"_textfield_"+i).val()
                                $(@_viewSelector+"_textfield_"+i).css('font-size', '16')
                                arr.push(t)
                            text = JSON.stringify(arr)
                            @delegate.clickedButtonAtIndex(text, @_self)
                        when "JSAlertViewStyleDefault"
                            @delegate.clickedButtonAtIndex(1, @_self)
                $(@_viewSelector+"_form").dialog("close")
                @_self.removeFromSuperview()
        if (@cancel == true)
            cancelmethod =
                Cancel:=>
                    if (@delegate? && typeof @delegate.clickedButtonAtIndex == "function")
                        @delegate.clickedButtonAtIndex(0, @_self)
                    if (@delegate? && typeof @delegate.closedDialog == "function")
                        @delegate.closedDialog(@_self)
                    $(@_viewSelector+"_form").dialog("close")
                    @_self.removeFromSuperview()
            buttonhash['Cancel'] = cancelmethod['Cancel']
        alerthash =
            autoOpen: false
            width: 440
            height: dialogHeight
            modal: true
            closeOnEscape: true
            close:=>
                if (@delegate? && typeof @delegate.closedDialog == "function")
                    @delegate.closedDialog(@_self)
                $(@_viewSelector+"_form").dialog("close")
                @_self.removeFromSuperview()
        alerthash["buttons"] = buttonhash
        $(@_viewSelector+"_form").dialog(alerthash)

    setData:(@_data)->
        if ($(@_viewSelector+"_form").length)
            for i in [0...@_data.length]
                value = @_data[i]
                $(@_viewSelector+"_textfield_"+i).val(value)

    setCloseEvent:(@_closeEvent)->

    show:->
        if (@_closeEvent?)
            $(@_viewSelector+"_form").dialog
                close: =>
                    @_closeEvent(@_self)
        $(@_viewSelector+"_form").dialog("open")

    viewDidAppear:->
        @setAlertViewStyle(@_style)
