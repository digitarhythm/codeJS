#*****************************************
# JSSwitch - switch parts class
# Coded by kouichi.sakazaki 2013.05.20
#*****************************************

class JSSwitch extends JSControl
	constructor:(frame = JSRectMake(0, 2, 240, 24))->
		super(frame)
		@_bgColor = JSColor("clearColor")
		@_value = false

	setValue:(@_value)->
		if (@_value == true)
			$("input[name='"+@_objectID+"_radio']").val(['on'])
		else
			$("input[name='"+@_objectID+"_radio']").val(['off'])

	getValue:->
		val = $("input[name='"+@_objectID+"_radio']:checked").val()
		if (val == "on")
			ret = true
		else
			ret = false
		return ret

	viewDidAppear:->
		super()
		tag  = "<div id='"+@_objectID+"_switch' style='position:absolute;z-index:1;font-size:60%; margin:0;float:left;width:"+@_frame.size.width+"px;top:1px;'>"
		tag += "<input type='radio' id='"+@_objectID+"_off' name='"+@_objectID+"_radio' value='off'><label for='"+@_objectID+"_off'>OFF</label>"
		tag += "<input type='radio' id='"+@_objectID+"_on'  name='"+@_objectID+"_radio' value='on'><label for='"+@_objectID+"_on'>ON</label>"
		tag += "</div>"
		if ($(@_viewSelector+"_switch").length)
			$(@_viewSelector+"switch").remove()
		$(@_viewSelector).append(tag)
		@setValue(@_value)
		$(@_viewSelector).buttonset()
