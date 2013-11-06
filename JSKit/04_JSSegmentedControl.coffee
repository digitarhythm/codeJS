#*****************************************
# JSSegmentedControl - radio switch parts class
# Coded by kouichi.sakazaki 2013.11.05
#*****************************************

class JSSegmentedControl extends JSControl
	constructor:(@_dataarray)->
		super(JSRectMake(0, 0, 120, 32))
		@_bgColor = JSColor("clearColor")

	selectedSegmentIndex:(@_value)->

	getValue:->
		val = $("input[name='"+@_objectID+"_radio']:checked").val()
		if (val == undefined)
			val = -1
		return val

	viewDidAppear:->
		super()
		if (!@_dataarray?)
			return

		tag = '<div id="'+@_objectID+'_radio" style="width:'+@_frame.size.width+'px;height:'+@_frame.size.height+'px;">'
		for i in [0...@_dataarray.length]
			tag += '<input type="radio" id="'+@_objectID+'_radio_'+i+'" name="'+@_objectID+'_radio" value="'+i+'" /><label for="'+@_objectID+'_radio_'+i+'" style="width:'+(@_frame.size.width/@_dataarray.length)+'px;height:'+@_frame.size.height+'px;border:1px #f0f0f0 solid;">'+@_dataarray[i]+'</label>'
		tag += '</div>'

		if ($(@_viewSelector+"_radio").length)
			$(@_viewSelector+"_radio").remove()
		$(@_viewSelector).append(tag)
		if (@_value?)
			@selectedSegmentIndex(@_value)
		$(@_viewSelector+"_radio").buttonset()
