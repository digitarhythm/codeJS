##########################################
# JSListView list view manage class
# Coded by kouichi.sakazaki 2013.04.02
##########################################

class JSListView extends JSScrollView
	constructor:(frame)->
		super(frame)
		@_listData = null
		@_action = null
		@_style = "JSListStyleTypeStandard"
		@_textSize = 10
		
	setFrame:(frame)->
		super(frame)
		if ($(@_viewSelector+"_select").length)
			$(@_viewSelector+"_select").width(frame.size.width)
			$(@_viewSelector+"_select").height(frame.size.height)

	setListData:(list)->
		switch @_style
			when "JSListStyleTypeStandard", "JSListStyleTypeDropdown"
				if (@_style=="JSListStyleTypeStandard")
					size = 2
					@_listData = list
				else
					if (!list?)
						return
					size = 1
					JSLog(list+"\n--------------\n")
					@_listData = new Array("-select-")
					for item in list
						if (item == "-select-")
							continue
						@_listData.push(item)
			
				@_tag = "<select id='"+@_objectID+"_select' size='"+size+"' style='width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;'>"
				if (!@_listData?)
					@_listData = new Array()
				for i in [0...@_listData.length]
					value = @_listData[i]
					JSLog(value)
					disp = value
					@_tag += "<option id='"+i+"' value='"+i+"'>"+disp+"</option>"
				@_tag += "</select>"
				if ($(@_viewSelector+"_select").length)
					$(@_viewSelector+"_select").remove()
				$(@_viewSelector).append(@_tag)	
				
				$(@_viewSelector+"_select").css("background-color", "transparent")
				$(@_viewSelector+"_select").css("border", "0px transparent")
				$(@_viewSelector+"_select").css("z-index", "1")
				$(@_viewSelector+"_select").css("font-size", @_textSize+"pt")
				
				if (@_style=="JSListStyleTypeStandard")
					$(@_viewSelector+"_select").click (e) =>
						e.stopPropagation()
						select = $(@_viewSelector+"_select option:selected").val()
						if (@_action? && select?)
							@_action(select)
				else
					$(@_viewSelector+"_select").change (e) =>
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
					@_tag += "<tr id='"+i+"' class='ui-state-default' style='width:100%;'><td>"+disp+"</td></tr>"
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
				$(@_viewSelector+"_select").css("font-size", (@_textSize-4)+"pt")

		$(@_viewSelector+"_select").width(@_frame.size.width+"px")
		$(@_viewSelector+"_select").height(@_frame.size.height+"px")
		
	count:->
		return @_listData.length
		
	objectAtIndex:(index)->
		return @_listData[index]
		
	indexOfObject:(target)->
		num = @_listData.indexOf(target)
		return num
		
	setSelect:(select)->
		$(@_viewSelector+"_select").val(select)
	
	sortReflection:->
		if (@_style == "JSListStyleTypeSortable")
			arr = $(@_viewSelector+"_select").sortable("toArray")
			ret = new Array()
			for key, i in arr
				ret[i] = @_listData[key]
			@_listData = ret
		
	setTextSize:(@_textSize)->
		if (@_listData?)
			@setListData(@_listData)
		
	addTarget:(@_action)->
	
	setStyle:(@_style)->
		@setListData(@_listData)
	
	reload:->
		@setListData(@_listData)
	
	viewDidAppear:->
		super()
		@setListData(@_listData)
			



