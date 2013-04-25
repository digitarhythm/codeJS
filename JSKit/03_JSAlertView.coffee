##########################################
# JSAlertView - Dialog control class
# Coded by kouichi.sakazaki 2013.04.25
##########################################

class JSAlertView extends JSView
	constructor:(@_title, @_message, @_delegate)->
		super()
		@_bgColor = JSColor("clearColor")
		@_style = "JSAlertViewStylePlainTextInput"

	setAlertViewStyle:(@_style)->
		if ($(@_viewSelector+"_textfield").length)
			$(@_viewSelector+"_textfield").remove()
		
		@_tag  = '<div id="'+@_objectID+'_form" title="'+@_title+'">'
		@_tag += '<p class="validateTips">'+@_message+'</p>'
		@_tag += '<form>'
		@_tag += '<fieldset>'
		@_tag += '<input type="text" name="'+@_objectID+'_textfield" id="'+@_objectID+'_textfield" />'
		@_tag += '</fieldset>'
		@_tag += '</form>'
		@_tag += '</div>'
		@_tag += '<!--null-->'
		
	show:->
		$(@_viewSelector+"_form").dialog("open")
	
	viewDidAppear:->
		if (!@_tag?)
			@setAlertViewStyle(@_Style)
		
		$(@_viewSelector).append(@_tag)
		$(@_viewSelector+"_form").dialog
			autoOpen: false
			height: 300
			width: 350
			modal: true
			buttons:
				"OK":=>
					if (@_delegate? && typeof @_delegate.clickedButtonAtIndex == "function")
						@_delegate.clickedButtonAtIndex(1)
					$(@_viewSelector+"_form").dialog("close")
				Cancel:=>
					if (@_delegate? && typeof @_delegate.clickedButtonAtIndex == "function")
						@_delegate.clickedButtonAtIndex(0)
					$(@_viewSelector+"_form").dialog("close")
			close:=>
				$(@_viewSelector+"_form").dialog("close")

