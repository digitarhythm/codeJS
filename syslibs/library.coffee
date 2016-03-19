# debug write
JSLog = (a, b...) ->
    #console.log(a)
    for data in b
        a = a.replace('%@', data)
    console.log(a)
    return a

# format strings
sprintf = (a, b...)->
    for data in b
        match = a.match(/%0\d*@/)
        if (match?)
            repstr = match[0]
            num = parseInt(repstr.match(/\d+/))
            zero =""
            zero += "0" while (zero.length < num)
            data2 = (zero+data).substr(-num)
            a = a.replace(repstr, data2)
        else
            a = a.replace('%@', data)
    return a

# YES/NO dialog
isConfirm = (str) ->
    if (window.confirm(str))
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

#//////////////////////////////////////////////////////////////////////////////////////////

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

#//////////////////////////////////////////////////////////////////////////////////////////

# get browser size(not include scrolling bar)
getApplicationFrame=->
    frame = JSRectMake(0, 0, window.innerWidth - 1, window.innerHeight - 1)
    return frame

# get browser size(include scrolling bar)
getBounds=->
    frame = JSRectMake(0, 0, window.innerWidth, window.innerHeight)
    return frame

# Color management
JSColor = (color) ->
    ret = color
    switch color
        when "clearColor"
            ret = "transparent"

    return ret

#//////////////////////////////////////////////////////////////////////////////////////////

# Get Standard Path
JSSearchPathForDirectoriesInDomains = (kind) ->
    ret = ""
    switch kind
        when "JSLibraryDirectory"
            ret = "Library"
        when "JSDocumentDirectory"
            ret = "Documents"
        when "JSPictureDirectory"
            ret = "Media/Picture"
        when "JSSystemDirectory"
            ret = "syslibs"
        when "JSBackendDirectory"
            ret = "backend"

    return ret

#//////////////////////////////////////////////////////////////////////////////////////////

random = (max) ->
    return Math.floor(Math.random() * (max + 1))

#//////////////////////////////////////////////////////////////////////////////////////////

JSEscape = (str) ->
    if (str?)
        str = str.replace(/&/g, "&amp;")
        str = str.replace(/\'/g, "&quot;")
        str = str.replace(/\"/g, "&quot;")
        str = str.replace(/</g, "&lt;")
        str = str.replace(/>/g, "&gt;")
    return str

#//////////////////////////////////////////////////////////////////////////////////////////

objectNum = (obj)->
    if (obj?)
        return Object.keys(obj).length
    else
        return 0

#//////////////////////////////////////////////////////////////////////////////////////////

isTouch =->
    return ('ontouchstart' of window)

#//////////////////////////////////////////////////////////////////////////////////////////

isAndroid =->
    return navigator.userAgent.indexOf('Android') != -1

#//////////////////////////////////////////////////////////////////////////////////////////

getBrowser =->
    ua = navigator.userAgent
    if (ua.match(".*iPhone.*"))
        kind = 'iOS'
    else if (ua.match(".*Android"))
        kind = 'Android'
    else if (ua.match(".*Windows.*"))
        kind = 'Windows'
    else if (ua.match(".*BlackBerry.*"))
        kind = 'BlackBerry'
    else if (ua.match(".*Symbian.*"))
        kind = 'Symbian'
    else if (ua.match(".*Macintosh.*"))
        kind = 'Mac'
    else if (ua.match(".*Linux.*"))
        kind = 'Linux'
    else
        kind = 'Unknown'

    if (ua.match(".*Safari.*") && !ua.match(".*Android.*") && !ua.match(".*Chrome.*"))
        browser = 'Safari'
    else if (ua.match(".*Gecko.*Firefox.*"))
        browser = "Firefox"
    else if (ua.match(".*Opera*"))
        browser = "Opera"
    else if (ua.match(".*MSIE*"))
        browser = "MSIE"
    else if (ua.match(".*Gecko.*Chrome.*"))
        browser = "Chrome"
    else
        browser = 'Unknown'

    return {'kind':kind, 'browser':browser}
