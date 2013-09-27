#*****************************************
# JSLocation - location data class
# Coded by kouichi.sakazaki 2013.09.26
#*****************************************

class JSLocation extends JSObject
	constructor:-> 
		super()
		@_coordinate = {latitude:null, longitude:null}
