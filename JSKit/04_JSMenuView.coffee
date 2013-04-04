##########################################
# JSMenuView - Menu control class
# Coded by kouichi.sakazaki 2013.04.04
##########################################

class JSMenuView extends JSScrollView
	constructor:(frame)->
		super(frame)
		@_backgroundColor = "gray"
	
	addMenuItem:(@_menuitem)->
		debug("addMenuItem")
		if (!@_menuitem?)
			debug("return")
			return
			
		@_div = "<ul id='"+@_objectID+"_menu'><!--menuitem--></ul>"
		menustr = ""
		for disp of @_menuitem
			menustr += "<li><a href='#'>"+disp+"</a></li>"	
		@_div = @_div.replace(/<!--menuitem-->/, menustr)
		
		debug(@_div)
		
		if (!$(@_viewSelector).length)
			return
		
		if ($(@_viewSelector+"_menu").length)
			$(@_viewSelector+"_menu").remove()
		
		$(@_viewSelector).append(@_div)
		$(@_viewSelector+"_menu").menu()

	viewDidAppear:->
		super()
		@addMenuItem(@_menuitem)