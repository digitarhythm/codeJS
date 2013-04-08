# debug write
debug = (a) ->
	console.log(a)
	
# YES/NO dialog
isConfirm = (str) ->
	if (window.confirm(str.string))
		return 1

# get cookie value
getCookieValue = (arg) ->
	if (arg)
		cookieData = document.cookie + ";"
		startPoint1 = cookieData.indexOf(arg)
		startPoint2 = cookieData.indexOf("=",startPoint1)+1
		endPoint = cookieData.indexOf(";",startPoint1)
		if(startPoint2 < endPoint && startPoint1 > -1)
			cookieData = cookieData.substring(startPoint2,endPoint)
			cookieData = cookieData
			return cookieData
	return false

# get unique id
UniqueID = ->
	S4 = ->
		return (((1+Math.random())*0x10000)|0).toString(16).substring(1)
	return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4())

# create JSRect
JSRectMake = (x, y, w, h) ->
	frame = new JSRect()
	frame.origin.x = x
	frame.origin.y = y
	frame.size.width = w
	frame.size.height = h
	return frame

# create JSPoint
JSPointMake = (x, y) ->
	point = new JSPoint()
	point.x = x
	point.y = y
	return point
  
# create JSSize
JSSizeMake = (w, h) ->
	size = new JSSize()
	size.width = w
	size.height = h
	return size
	
# create JSRange
JSMakeRange = (loc, len) ->
	range = new JSRange()
	range.location = loc
	range.length = len
	return range
	
# get browser size(not include scrolling bar)
getApplicationFrame=->
	frame = new JSRect(0, 0, $("html").innerWidth(), $("html").innerHeight())
	return frame
		
# get browser size(include scrolling bar)
getBounds=->
	frame = JSRectMake(0, 0, document.documentElement.clientWidth, document.documentElement.clientHeight)
	return frame

# Color management
JSColor = (color) ->
	ret = color
	switch color
		when "clearColor"
			ret = "transparent"

	return ret
	
# Get Standard Path
JSSearchPathForDirectoriesInDomains = (kind) ->
	ret = ""
	switch kind
		when "JSLibraryDirectory"
			ret = "Library"
		when "JSDocumentDirectory"
			ret = "Documents"
	
	return ret

