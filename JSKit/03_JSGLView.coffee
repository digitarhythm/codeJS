##########################################
# JSGLView - WebGL view class
# Coded by kouichi.sakazaki 2013.04.05
##########################################

class JSGLView extends JSView
	constructor:(frame)->
		if ($("#enchant-stage").length)
			alert "すでにenchantのステージがあります。"
			@removeFromSuperview()
		else	
			super(frame)
			@_bgColor = JSColor("clearColor")
			@_borderColor = JSColor("clearColor")
			@_div = @_div.replace(/<!--null-->/, "<div id='enchant-stage'>gl.enchant.js</div><!--null-->")
			
	viewDidAppear:->
		super()
		$(@_viewSelector+" #enchant-stage").css("zIndex", "1")
		$(@_viewSelector+" #enchant-stage").width(@_frame.size.width)
		$(@_viewSelector+" #enchant-stage").height(@_frame.size.height)

		enchant()
		@_game = Game(@_frame.size.width, @_frame.size.height)
		
		# 3D 用シーン生成
		@_scene = new Scene3D()

