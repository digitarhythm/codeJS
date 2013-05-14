#*****************************************
# JSAlertView - Dialog control class
# Coded by kouichi.sakazaki 2013.04.25
#*****************************************

class JSAlertView extends JSView
	constructor:(@_title, @_message, @_param = null)->
		super()
		@_bgColor = JSColor("clearColor")
		@_style = "JSAlertViewStyleDefault"
		@delegate = null

	setAlertViewStyle:(@_style)->
		@_tag  = "<div id='"+@_objectID+"_form' title='"+@_title+"'>"
		@_tag += "<style>"
		@_tag += "body{font-size:60%;}"
		@_tag += "label{vertical-align:bottom;}"
		@_tag += "</style>"
		@_tag += "<p class='validateTips'>"+@_message+"</p>"
		if (@_style == "JSAlertViewStylePlainTextInput" && @_param?)
			dialogHeight = 144+(36*@_param.length)
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
		else
			dialogHeight = 160
		@_tag += "</div>"
		@_tag += "<!--null-->"
		if ($(@_viewSelector+"_form").length)
			$(@_viewSelector+"_form").remove()
		$(@_viewSelector).append(@_tag)
		$(@_viewSelector+"_form").dialog
			autoOpen: false
			width: 350
			height: dialogHeight
			modal: true
			buttons:
				"OK":=>
					if (@delegate? && typeof @delegate.clickedButtonAtIndex == "function")
						switch @_style
							when "JSAlertViewStylePlainTextInput"
								arr = []
								for i in [0...@_param.length]
									t = $(@_viewSelector+"_textfield_"+i).val()
									arr.push(t)
								text = JSON.stringify(arr)
								@delegate.clickedButtonAtIndex(text)
							when "JSAlertViewStyleDefault"
								@delegate.clickedButtonAtIndex(1)
					$(@_viewSelector+"_form").dialog("close")
					@_self.removeFromSuperview()
				Cancel:=>
					if (@delegate? && typeof @delegate.clickedButtonAtIndex == "function")
						@delegate.clickedButtonAtIndex(0)
					$(@_viewSelector+"_form").dialog("close")
					@_self.removeFromSuperview()
			close:=>
				$(@_viewSelector+"_form").dialog("close")
				@_self.removeFromSuperview()
	
	setData:(@_data)->
		if ($(@_viewSelector+"_form").length)
			for i in [0...@_data.length]
				value = @_data[i]
				$(@_viewSelector+"_textfield_"+i).val(value)

	show:->
		$(@_viewSelector+"_form").dialog("open")
	
	viewDidAppear:->
		@setAlertViewStyle(@_style)
