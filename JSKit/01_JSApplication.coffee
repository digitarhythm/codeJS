##########################################
# JSApplication - Application method class
# Coded by kouichi.sakazaki 2013.04.06
##########################################

class JSApplication extends JSObject
	constructor:->
	# get browser size(not include scrolling bar)
	applicationFrame:->
		frame = new JSRect(0, 0, $("html").innerWidth(), $("html").innerHeight())
		return frame
			
	# get browser size(include scrolling bar)
	bounds:->
		frame = JSRectMake(0, 0, document.documentElement.clientWidth, document.documentElement.clientHeight)
		return frame
		
