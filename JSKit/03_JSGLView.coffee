#*****************************************
# JSGLView - WebGL view class
# Coded by kouichi.sakazaki 2013.04.05
#*****************************************

class JSGLView extends JSView
	constructor:(frame = JSRectMake(0, 0, 320, 240), @_bgColor = "#f0f0f0", @_alpha = 1.0, @_antialias = true)->
		super(frame)
		
		# init values
		@_perspective = 15
		@_camera_x = 0
		@_camera_y = 0
		@_camera_z = 10
		@_lookat_x = 0
		@_lookat_y = 0
		@_lookat_z = 0
		@_lightcolor = 0xffffff
		@_lightdir_x = 0.577
		@_lightdir_y = 0.577
		@_lightdir_z = 0.577
		@_ambientLightColor = 0x404040
		
		@delegate = @_self
		
		# init rendere
		@_renderer = new THREE.WebGLRenderer({ antialias:@_antialias })
		@_renderer.setSize(frame.size.width, frame.size.height)
		@_renderer.setClearColorHex(@_bgcolor, @_alpha)
	
	setCamera:(@_perspective, @_camera_x, @_camera_y, @_camera_z, @_lookat_x, @_lookat_y, @_lookat_z)->
		# init camera
		@_camera = new THREE.PerspectiveCamera(@_perspective, @_frame.size.width / @_frame.size.height);
		@_camera.position = new THREE.Vector3(@_camera_x, @_camera_y, @_camera_z);
		@_camera.lookAt(new THREE.Vector3(@_lootat_x, @_lootat_y, @_lootat_z));
		@_scene.add(@_camera);
 
	setLight:(@_lightcolor, @_lightdir_x, @_lightdir_y, @_lightdir_z)->
		#init light
		@_light = new THREE.DirectionalLight(@_lightcolor)
		@_light.position = new THREE.Vector3(@_lightdir_x, @_lightdir_y, @_lightdir_z);
		@_scene.add(@_light);
 
	setAmbient:(@_ambientLightColor)->
		@_ambient = new THREE.AmbientLight(@_ambientLightColor)
		@_scene.add(@_ambient);

	render:=>
		@_baseTime = +new Date;
		@render_sub()
	
	render_sub:=>
		requestAnimationFrame(@render_sub);
		@delegate.enterFrame()
		@_renderer.render(@_scene, @_camera);

	viewDidAppear:->
		super()
		$(@_viewSelector).append(@_renderer.domElement)
		@_scene = new THREE.Scene()
		@setCamera(@_perspective, @_camera_x, @_camera_y, @_camera_z, @_lookat_x, @_lootat_y, @_lookat_z)
		@setLight(@_lightcolor, @_lightdir_x, @_lightdir_y, @_lightdir_z) 
		@setAmbient(@_ambientLightColor)

