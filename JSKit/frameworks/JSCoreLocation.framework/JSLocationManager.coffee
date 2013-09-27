#*****************************************
# JSLocationManager - get location API
# Coded by kouichi.sakazaki 2013.09.25
#*****************************************

class JSLocationManager extends JSObject
	constructor:-> 
		super()
		@_location = new JSLocation()
		@_oldcoord = new JSLocation()
		@delegate = @_self
		@_cancelID = null

	locationServicesEnabled:->
		ret = navigator.geolocation
		if (ret)
			return true
		else
			return false
	
	startUpdatingLocation:->
		@_cancelID = requestAnimationFrame(@enterFrame)
		
	stopUpdatingLocation:->
		if (@_cancelID != null)
			cancelAnimationFrame(@_cancelID)
			@_cancelID = null
	
	enterFrame:=>
		if (@_cancelID == null)
			return
		navigator.geolocation.getCurrentPosition (event)=>
			lat = event.coords.latitude
			lng = event.coords.longitude
			if (lat != @_location._coordinate['latitude'] || lng != @_location._coordinate['longitude'])
				if (typeof @delegate.didUpdateToLocation == 'function')
					@_oldcoord._coordinate['latitude'] = @_location._coordinate['latitude']
					@_oldcoord._coordinate['longitude'] = @_location._coordinate['longitude']
					@_location._coordinate['latitude'] = lat
					@_location._coordinate['longitude'] = lng
					@delegate.didUpdateToLocation(@_oldcoord, @_location)
		, @errorCallback
		@_cancelID = requestAnimationFrame(@enterFrame)
	
	errorCallback:(err)=>
		if (typeof @delegate.didFailWithError == 'function')
			@delegate.didFailWithError(err)