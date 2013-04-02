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
		size = @listData.length
		@_tag = "<div id='"+@_viewSelector+"_div' style='position:absolute;overflow:scroll;'><select name='"+@_viewSelector+"_select' size='"+size+"'>"
		if (!@listData?)
			return
		for value of @listData
			disp = @listData[value]
			@_tag += "<option value='"+value+"'>"+disp
		@_tag += "</select></div>"
		debug(@_tag)
	
	viewDidAppear:->
		$(@_viewSelector).append(@_tag)	

