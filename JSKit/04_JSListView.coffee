##########################################
# JSListView list view manage class
# Coded by kouichi.sakazaki 2013.04.02
##########################################

class JSListView extends JSScrollView
	constructor:(frame)->
		super(frame)
		@_listData = null
		@_action = null
		@style = "JSListStyleTypeStandard"
		
	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").width(frame.size.width)
			$(@_viewSelector+"_select").height(frame.size.height)

	setDataList:(@_listData)->
		switch @style
			when "JSListStyleTypeStandard"
				size = @_listData.length
				if (size < 2)
					size = 2
				@_tag = "<form><select id='"+@_objectID+"_select' size='"+size+"' style='width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;'>"
				if (!@_listData?)
					return
				for i in [0...@_listData.length]
					value = @_listData[i]
					disp = value
					@_tag += "<option value='"+i+"'>"+disp+"</option>"
				@_tag += "</select></form>"
				if ($(@_viewSelector+"_select").length)
					$(@_viewSelector+"_select").remove()
				$(@_viewSelector).append(@_tag)	
				$(@_viewSelector+"_select").css("background-color", "transparent")
				$(@_viewSelector+"_select").css("border", "0px transparent")
				$(@_viewSelector+"_select").css("z-index", "1")
				
				$(@_viewSelector+"_select").click (e) =>
					e.stopPropagation()
					select = $(@_viewSelector+"_select option:selected").val()
					if (@_action? && select?)
						@_action(select)
						
			when "JSListStyleTypeSortable"
				@_tag = "<table style='width:100%;'><tbody id='"+@_objectID+"_select'>"
				if (!@_listData?)
					return
				for i in [0...@_listData.length]
					value = @_listData[i]
					disp = value
					@_tag += "<tr class='ui-state-default' style='width:100%;'><td>"+disp+"</td></tr>"
				@_tag += "</tbody></table>"
				if ($(@_viewSelector+"_select").length)
					$(@_viewSelector+"_select").remove()
				$(@_viewSelector).append(@_tag)
				
				$(@_viewSelector+"_select").sortable
					placeholder: "ui-sortable-placeholder"
					distance: 3
					opacity:0.8
					
				$(@_viewSelector+"_select").disableSelection()
				
				$(@_viewSelector+"_select").css("background-color", "transparent")
				$(@_viewSelector+"_select").css("border", "0px transparent")
				$(@_viewSelector+"_select").css("z-index", "1")

		$(@_viewSelector+"_select").width(@_frame.size.width+"px")
		$(@_viewSelector+"_select").height(@_frame.size.height+"px")		
		
	addTarget:(@_action)->
	
	reload:->
		@setDataList(@_listData)
	
	viewDidAppear:->
		super()
		@setDataList(@_listData)
			