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
		for i in [0...@_listData.count()]
			value = @_listData.objectAtIndex(i)
			disp = value.string
			@_tag += "<option value='"+i+"'>"+disp+"</option>"
		@_tag += "</select></form>"
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").remove()
		$(@_viewSelector).append(@_tag)	
		$(@_viewSelector+"_select").css("background-color", "transparent")
		$(@_viewSelector+"_select").css("border", "0px transparent")
		
		$(@_viewSelector+"_select").click (e) =>
			e.stopPropagation()
		$(@_viewSelector+"_select").change =>
			select = $(@_viewSelector+"_select option:selected").val()
			debug("action="+@_action)
			if (@_action?)
				@_action(select)

		$(@_viewSelector+"_select").width(@_frame.size.width+"px")
		$(@_viewSelector+"_select").height(@_frame.size.height+"px")		
		
	addTarget:(@_action)->
		debug("set action="+@_action)
	
	reload:->
		@setDataList(@_listData)
	
	viewDidAppear:->
		super()
		@setDataList(@_listData)
			