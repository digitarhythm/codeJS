##########################################
# JSView - base class of all view object
# Coded by kouichi.sakazaki 2013.03.25
##########################################

class JSView extends JSResponder
	constructor: (@_frame = JSRectMake(0, 0, 320, 240))->
		super()
		@_parent = null
		@_viewSelector = "#"+@_objectID
		@_bgColor = JSColor("#f0f0f0")
		@_alpha = 1
		@_cornerRadius = 0
		@_borderColor = JSColor("clearColor")
		@_borderWidth = 0
		@_clipToBounds = false
		@_draggable = false
		@_resizable = false
		@_containment = false
		@_div = "<div id=\"" + @_objectID + "\" style='position:absolute;'><!--null--></div>"
		@_objlist = new JSMutableArray()
		@_shadow = false

	addSubview: (object) ->
		if (!object?)
			return
			
		@_objlist.addObject(object)
		object._parent = @_self
			
		if ($(@_viewSelector).length)
			$(@_viewSelector).append(object._div)
			$(@_viewSelector).css("z-index", "1")
			object.setDraggable(object._draggable)
			object.setResizable(object._resizable)
			object.viewDidAppear()
		
	setFrame: (@_frame) ->
		if ($(@_viewSelector).length)
			$(@_viewSelector).width(@_frame.size.width+"px")
			$(@_viewSelector).height(@_frame.size.height+"px")
			$(@_viewSelector).css("left", @_frame.origin.x+"px")
			$(@_viewSelector).css("top", @_frame.origin.y+"px")

	setBackgroundColor: (@_bgColor) ->
		if ($(@_viewSelector).length)
			$(@_viewSelector).css("background-color", @_bgColor)
		
	setAlpha: (@_alpha) ->
		if (@_alpha < 0 or @_alpha > 1)
			return
		if ($(@_viewSelector).length)
			$(@_viewSelector).css("opacity", @_alpha)

	setCornerRadius: (@_cornerRadius) ->
		if ($(@_viewSelector).length)
			$(@_viewSelector).css("-webkit-border-radius", @_cornerRadius+"px")
			$(@_viewSelector).css("-moz-border-radius", @_cornerRadius+"px")
			$(@_viewSelector).css("border-radius", @_cornerRadius+"px")
	
	setBorderColor: (@_borderColor) ->
		if ($(@_viewSelector).length)
			$(@_viewSelector).css("border-color", @_borderColor)
			$(@_viewSelector).css("border-style", "solid")
			$(@_viewSelector).css("border-width", @_borderWidth)
		
	setBorderWidth: (@_borderWidth) ->
			$(@_viewSelector).css("border-width", @_borderWidth)
			$(@_viewSelector).css("border-style", "solid")
			$(@_viewSelector).css("border-width", @_borderWidth)

	setClipToBounds: (@_clipToBounds) ->
		if ($(@_viewSelector).length)
			if (@_clipToBounds == false)
				$(@_viewSelector).css("overflow", "visible")
			else
				$(@_viewSelector).css("overflow", "hidden")
			
	setDraggable: (@_draggable) ->
		if (@_parent?)
			containment = @_parent._containment
		else
			containment = false
			
		if (!$(@_viewSelector).length)
			return
			
		if (@_draggable == true)
			$(@_viewSelector).css("cursor", "pointer")
			if (containment == true)
				$(@_viewSelector).draggable({containment:"parent", opacity:0.5, disabled: false})
			else
				$(@_viewSelector).draggable({opacity:0.5, disabled: false})
				$(@_viewSelector).draggable("destroy")
				$(@_viewSelector).draggable({opacity:0.5, disabled: false})
		else
			$(@_viewSelector).css("cursor", "normal")
			$(@_viewSelector).draggable({disabled: true})
			
	setResizable: (@_resizable, @_resizeAction = null, minWidth = 0, minHeight = 0, maxWidth = 16777216, maxHeight = 16777216) ->
		if (@_parent?)
			containment = @_parent._containment
		else
			containment = false
			
		if (!$(@_viewSelector).length)
			return
			
		if (@_resizable == true)
			if (containment == true)
				debug("resize1")
				$(@_viewSelector).resizable
					containment:"parent"
					minWidth:minWidth
					minHeight:minHeight
					maxWidth:maxWidth
					maxHeight:maxHeight
					resize: (event, ui) =>
						@_resizeAction()
			else
				debug("resize2")
				$(@_viewSelector).resizable
					opacity:0.5
					disabled: false
				$(@_viewSelector).resizable("destroy")
				$(@_viewSelector).resizable
					minWidth:minWidth
					minHeight:minHeight
					maxWidth:maxWidth
					maxHeight:maxHeight
					opacity:0.5
					disabled: false
					resize: (event, ui) =>
						@_resizeAction()
			
	setContainment:(@_containment) ->
		for obj in @_objlist.array
			obj.setDraggable(obj._draggable)
			
	bringSubviewToFront:(obj)->
		id = obj._objectID
		v = $('#' + id)
		v.appendTo(v.parent())
		
	removeFromSuperview:=>
		if (@_parent == null)
			return
		t = -1
		i = 0
		for o in @_parent._objlist.array
			if (o._objectID == @_objectID)
				t = i
				break;
			i++
		if ( t >= 0)
			@_parent._objlist.removeObjectAtIndex(t)
			$(@_viewSelector).remove()
	
	addTapGesture:(tapAction, tapnum = 1)=>
		if (tapnum == 1)
			@_tapAction = tapAction
		if (tapnum == 2)
			@_tapAction2 = tapAction
			
		if (!$(@_viewSelector).length)
			return
		if (tapnum == 1)
			$(@_viewSelector).unbind("click").bind "click", (event) =>
				if (@_tapAction?)
					@_tapAction(@_self)
#					event.stopPropagation()
					
		if (tapnum == 2)
			$(@_viewSelector).unbind("dblclick").bind "dblclick", (event) =>
				if (@_tapAction2?)
					@_tapAction2(@_self)
#					event.stopPropagation()
				
	animateWithDuration:(duration, animations, completion = null)=>
		duration *= 1000
		animtmp = animations.dictionary
		animobj = {}
		for key of animtmp
			value = animtmp[key]
			if (key == "alpha")
				key = "opacity"
			animobj[key] = value
				
		if (completion?)
			$(@_viewSelector).animate animobj, duration, => completion(@_self)
		else
			$(@_viewSelector).animate animobj, duration
			
	setShadow:(@_shadow)->
		if (@_shadow == true)
			$(@_viewSelector).css("box-shadow", "2px 2px 10px rgba(0,0,0,0.4)")
		else
			$(@_viewSelector).css("box-shadow", "none")
  
	viewDidAppear: ->
		@setFrame(@_frame)
		@setBackgroundColor(@_bgColor)
		@setCornerRadius(@_cornerRadius)
		@setAlpha(@_alpha)
		@setBorderColor(@_borderColor)
		@setBorderWidth(@_borderWidth)
		@setShadow(@_shadow)
		@setClipToBounds(@_clipToBounds)
		@setDraggable(@_draggable)
		if (@_tapAction?)
			@addTapGesture(@_tapAction)
		if (@_tapAction2?)
			@addTapGesture(@_tapAction2, 2)

		if (@_objlist.count() > 0)
			for i in [0...@_objlist.count()]
				o = @_objlist.objectAtIndex(i)
				if (!$(o._viewSelector).length)
					$(@_viewSelector).append(o._div)
					o.setDraggable(o._draggable)
					o.viewDidAppear()
			
			
		