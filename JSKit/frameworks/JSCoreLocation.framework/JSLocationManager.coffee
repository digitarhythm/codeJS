#*****************************************
# JSLocationManager - get location API
# Coded by kouichi.sakazaki 2013.09.25
#*****************************************

class JSLocationManager extends JSObject
  constructor:-> 
    super()
    @_location = new JSLocation()
    @_oldcoord = new JSLocation()
    @_calcelID = null

    @delegate = @_self


  locationServicesEnabled:->
    ret = navigator.geolocation
    if (ret)
      return true
    else
      return false
  
  startUpdatingLocation:->
    position_options =
      enableHighAccuracy: true
      timeout: 60000
      maximumAge: 0
    @_cancelID = navigator.geolocation.watchPosition(@successCallback, @errorCallback, position_options)
    
  stopUpdatingLocation:->
    if (@_cancelID != null)
      navigator.geolocation.clearWatch(@_cancelID)
      @_cancelID = null
  
  successCallback:(event)=>
    if (@_cancelID == null)
      return
    if (typeof @delegate.didUpdateToLocation == 'function')
      lat = event.coords.latitude
      lng = event.coords.longitude
      @_oldcoord._latitude = @_location._latitude
      @_oldcoord._longitude = @_location._longitude
      @_location._latitude = lat
      @_location._longitude = lng
      @delegate.didUpdateToLocation(@_oldcoord, @_location)
  
  errorCallback:(err)=>
    if (typeof @delegate.didFailWithError == 'function')
      @delegate.didFailWithError(err)
