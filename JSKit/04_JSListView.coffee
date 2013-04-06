##########################################
# JSListView list view manage class
# Coded by kouichi.sakazaki 2013.04.02
##########################################

class JSListView extends JSScrollView
	constructor:(frame)->
		super(frame)
		@listData = null
		
	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").width(frame.size.width)
			$(@_viewSelector+"_select").height(frame.size.height)

	setDataList:(@listData)->
		size = @listData.count()
		if (size < 2)
			size = 2
		@_tag = "<select id='"+@_viewSelector+"_select' size='"+size+"' style='width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;'>"
		if (!@listData?)
			return
		for value of @listData.dictionary
			disp = @listData.objectForKey(value.string)
			@_tag += "<option value='"+value+"'>"+disp.string+"</option>"
		@_tag += "</select>"
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").remove()
		$(@_viewSelector).append(@_tag)	
#		$(@_viewSelector+"_select").width(@_frame.size.width+"px")
#		$(@_viewSelector+"_select").height(@_frame.size.height+"px")		
	
	viewDidAppear:->
		super()
		if (@listData?)
			@setDataList(@listData)
		