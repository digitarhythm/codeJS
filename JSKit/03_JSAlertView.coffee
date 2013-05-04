##########################################
# JSAlertView - Dialog control class
# Coded by kouichi.sakazaki 2013.04.25
##########################################

class JSAlertView extends JSView
	constructor:(@_title, @_message, @_delegate = null, @_param = null)->
		super()
		@_bgColor = JSColor("clearColor")
		@_style = "JSAlertViewStyleDefault"

	setAlertViewStyle:(@_style)->
	
	setData:(@_data)->
		if ($(@_viewSelector+"_form").length)
			for i in [0...@_data.length]
				value = @_data[i]
				$(@_viewSelector+"_textfield_"+i).val(value)

	show:->
		$(@_viewSelector+"_form").dialog("open")
	
	viewDidAppear:->
		@_tag  = "<div id='"+@_objectID+"_form' title='"+@_title+"'>"
		@_tag += "<style>body{font-size:60%;}</style>"
		@_tag += "<p class='validateTips'>"+@_message+"</p>"
		if (@_style == "JSAlertViewStylePlainTextInput" && @_param?)
			@_tag += "<form onSubmit='return false;'>"
			@_tag += "<fieldset>"
			for i in [0...@_param.length]
				p = @_param[i]
				if (@_data?)
					value = @_data[i]
				else
					value = ""
				@_tag += "<label>"+p+"</labeL>"
				addtag = "<input type='text' name='"+@_objectID+"_textfield_"+i+"' id='"+@_objectID+"_textfield_"+i+"' style='width:"+(@_frame.size.width-32)+"px;' value='"+value+"' /><br>"
				@_tag += addtag
			@_tag += "</fieldset>"
			@_tag += "</form>"
		@_tag += "</div>"
		@_tag += "<!--null-->"
		$(@_viewSelector).append(@_tag)
		$(@_viewSelector+"_form").dialog
			autoOpen: false
			height: 300
			width: 350
			modal: true
			buttons:
				"OK":=>
					if (@_delegate? && typeof @_delegate.clickedButtonAtIndex == "function")
						switch @_style
							when "JSAlertViewStylePlainTextInput"
								arr = []
								for i in [0...@_param.length]
									t = $(@_viewSelector+"_textfield_"+i).val()
									arr.push(t)
								text = JSON.stringify(arr)
								@_delegate.clickedButtonAtIndex(text)
							when "JSAlertViewStyleDefault"
								@_delegate.clickedButtonAtIndex(1)
					$(@_viewSelector+"_form").dialog("close")
					@_self.removeFromSuperview()
				Cancel:=>
					if (@_delegate? && typeof @_delegate.clickedButtonAtIndex == "function")
						@_delegate.clickedButtonAtIndex(0)
					$(@_viewSelector+"_form").dialog("close")
					@_self.removeFromSuperview()
			close:=>
				$(@_viewSelector+"_form").dialog("close")
				@_self.removeFromSuperview()

