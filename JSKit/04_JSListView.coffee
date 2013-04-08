##########################################
# JSListView list view manage class
# Coded by kouichi.sakazaki 2013.04.02
##########################################

class JSListView extends JSScrollView
	constructor:(frame)->
		super(frame)
		@_listData = null
		@_action = null
		
	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").width(frame.size.width)
			$(@_viewSelector+"_select").height(frame.size.height)

	setDataList:(@_listData)->
		size = @_listData.count()
		if (size < 2)
			size = 2
		@_tag = "<form><select id='"+@_objectID+"_select' size='"+size+"' style='width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;z-index:1;'>"
		if (!@_listData?)
			return
		for value of @_listData.dictionary
			disp = @_listData.objectForKey(value)
			@_tag += "<option value='"+value+"'>"+disp.string+"</option>"
		@_tag += "</select></form>"
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").remove()
		$(@_viewSelector).append(@_tag)	
		
		$(@_viewSelector+"_select").change =>
			select = $(@_viewSelector+"_select option:selected").val()
			if (@_action?)
				@_action(select)

		$(@_viewSelector+"_select").width(@_frame.size.width+"px")
		$(@_viewSelector+"_select").height(@_frame.size.height+"px")		
		
	addTarget:(@_action)->
	
	viewDidAppear:->
		super()
		if (@_listData?)
			@setDataList(@_listData)
			