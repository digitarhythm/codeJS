#*****************************************
# JSSegmentedControl - radio switch parts class
# Coded by kouichi.sakazaki 2013.11.05
#*****************************************

class JSSegmentedControl extends JSControl
	constructor:(@_dataarray)->
		super(JSRectMake(0, 0, 120, 32))
		@_bgColor = JSColor("clearColor")
		@_selectedSegmentIndex = -1

	setValue:(@_selectedSegmentIndex)->
		if ($(@_viewSelector).length)
			$("input:radio[name='"+@_objectID+"_radio'][value='"+@_selectedSegmentIndex+"']").attr("checked", "checke")
			$(@_viewSelector+"_radio").buttonset('refresh')

	viewDidAppear:->
		super()
		if (!@_dataarray?)
			return

		tag = '<div id="'+@_objectID+'_radio" style="width:'+@_frame.size.width+'px;height:'+@_frame.size.height+'px;">'
		for i in [0...@_dataarray.length]
			tag += '<input type="radio" id="'+@_objectID+'_radio_'+i+'" name="'+@_objectID+'_radio" value="'+i+'" /><label for="'+@_objectID+'_radio_'+i+'" style="width:'+(@_frame.size.width/@_dataarray.length)+'px;height:'+@_frame.size.height+'px;border:1px #f0f0f0 solid;vertical-align:middle;display:table-cell;">'+@_dataarray[i]+'</label>'
		tag += '</div>'

		if ($(@_viewSelector+"_radio").length)
			$(@_viewSelector+"_radio").remove()
		$(@_viewSelector).append(tag)
		$(@_viewSelector+"_radio").buttonset().click(=>
			@_selectedSegmentIndex = $("input[name='"+@_objectID+"_radio']:checked").val()
			if (@action?)
				@action(@_self)
		)
		@setValue(@_selectedSegmentIndex)
