#*****************************************
# JSMapView - GoogleMaps manage class
# Coded by kouichi.sakazaki 2013.10.03
#*****************************************

class JSMapView extends JSView
	constructor: (frame)->
		super(frame)
		@delegate = @_self

	setRegion:(zoom)->
		if ($(@_viewSelector+"_mapcanvas").length)
			@_map.setZoom(zoom)

	getRegion:->
		if ($(@_viewSelector+"_mapcanvas").length)
			return @_map.getZoom()
		else
			return 0
	
	setMapType:(maptype)->
		if ($(@_viewSelector+"_mapcanvas").length)
			switch (maptype)
				when "MKMapTypeHybrid"
					maptypeid = google.maps.MapTypeId.HYBRID
				when "MKMapTypeStandard"
					maptypeid = google.maps.MapTypeId.ROADMAP
				when "MKMapTypeSatellite"
					maptypeid = google.maps.MapTypeId.SATELLITE
				when "MKMapTypeTerrain"
					maptypeid = google.maps.MapTypeId.TERRAIN
			@_map.setMapTypeId(maptypeid)

	createMap:->
		tag = "<div id='"+@_objectID+"_mapcanvas' style='width:"+@_frame.size.width+"px;height:"+@_frame.size.height+"px;'></div>"
		if ($(@_viewSelector+"_mapcanvas").length)
			$(@_viewSelector+"_mapcanvas").remove()
		$(@_viewSelector).append(tag)
		mapOptions =
			center: new google.maps.LatLng(0.0, 0.0)
			zoom: 8
			mapTypeId: google.maps.MapTypeId.ROADMAP
			panControl: false
			zoomControl: false
			mapTypeControl: false
			scaleControl: false
			streetViewControl: false
			overviewMapControl: false
		@_map = new google.maps.Map(document.getElementById(@_objectID+"_mapcanvas"), mapOptions)
	
	setCenterCoordinate:(coord)->
		if ($(@_viewSelector+"_mapcanvas").length)
			latitude = coord._latitude
			longitude = coord._longitude
			@_center = new google.maps.LatLng(latitude, longitude)
			@_map.setCenter(@_center)

	viewDidAppear:->
		super()
		if (!$(@_viewSelector+"_mapcanvas").length)
			@createMap()
