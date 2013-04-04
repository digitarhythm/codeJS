##########################################
# JSMenuView - Menu control class
# Coded by kouichi.sakazaki 2013.04.04
##########################################

class JSMenuView extends JSScrollView
	constructor:(@_action = null)->
		debug(@_action)
		super(JSRectMake(0, 0, 200, 0))
		@_textSize = 10
		@_backgroundColor = JSColor("clearColor")
		@_clipToBounds = false
		@_containment = false
	
	addMenuItem:(@_menuitem)->
		if (!@_menuitem?)
			return
			
		if (!$(@_viewSelector).length)
			return
			
		@_div = "<ul id='"+@_objectID+"_menu'><!--menuitem--></ul>"
		menustr = ""
		for disp in @_menuitem.array
			menustr += "<li><a href='#'>"+disp+"</a></li>"	
		@_div = @_div.replace(/<!--menuitem-->/, menustr)
		
		if ($(@_viewSelector+"_menu").length)
			$(@_viewSelector+"_menu").remove()
			
		$(@_viewSelector).append(@_div)
		$(@_viewSelector+"_menu").css("top", @_parent._frame.size.height+"px")
		$(@_viewSelector+"_menu").css("position", "absolute")
		$(@_viewSelector+"_menu").css("overflow", "scroll")
		$(@_viewSelector+"_menu").css("font-size", @_textSize+"pt")
		$(@_viewSelector+"_menu").menu
			select: (event, ui) =>
				item = ui.item.context.innerText
				@selectMenuItem(item)
				@closeMenu()
				
	selectMenuItem:(item)->
		debug("action")
		if (@_action?)
			@_action(item)
		
	closeMenu:=>
		$(@_viewSelector+"_menu").remove()
		event.stopPropagation()
		
	viewDidAppear:->
		super()
		if (!$(@_viewSelector+"_menu").length)
			@addMenuItem(@_menuitem)

