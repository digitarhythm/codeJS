#*****************************************
# JSSegmentedControl - radio switch parts class
# Coded by kouichi.sakazaki 2013.11.05
#*****************************************

class JSSegmentedControl extends JSControl
	constructor:(@_dataarray)->
		super(JSRectMake(0, 0, 120, 32))
		@_bgColor = JSColor("clearColor")
		@_selectedSegmentIndex = -1
		@_textSize = 12
	
	setValue:(@_selectedSegmentIndex)->
		if ($(@_viewSelector+"_radio").length)
			$("input:radio[name='"+@_objectID+"_radio'][value='"+@_selectedSegmentIndex+"']").attr("checked", "checked")
			$(@_viewSelector+"_radio").buttonset('refresh')

	setTextSize:(@_textSize)->

	viewDidAppear:->
		super()
		if (!@_dataarray?)
			return

		tag = '<div id="'+@_objectID+'_radio" style="width:'+@_frame.size.width+'px;height:'+@_frame.size.height+'px;display:table-cell;vertical-align:middle;">'
		for i in [0...@_dataarray.length]
			tag += '<input type="radio" id="'+@_objectID+'_radio_'+i+'" name="'+@_objectID+'_radio" value="'+i+'" /><label for="'+@_objectID+'_radio_'+i+'" style="width:'+(@_frame.size.width/@_dataarray.length)+'px;height:'+@_frame.size.height+'px;border:1px #f0f0f0 solid;font-size:'+@_textSize+'pt;"><div style="position:absolute;left:0px;top:0px;width:100%;height:100%;display:inline;line-height:'+@_frame.size.height+'px;">'+@_dataarray[i]+'</div></label>'
		tag += '</div>'

		if ($(@_viewSelector+"_radio").length)
			$(@_viewSelector+"_radio").remove()
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_radio").buttonset()
		$(@_viewSelector).unbind().bind 'tap', =>
			@_selectedSegmentIndex = $("input[name='"+@_objectID+"_radio']:checked").val()
			@action(@_self)
		@setValue(@_selectedSegmentIndex)
