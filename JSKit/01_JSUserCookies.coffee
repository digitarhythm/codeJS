#*****************************************
# JSUserCookies - User Cookie Class
# Coded by Hajime Oh-yake 2013.09.05
#*****************************************

class JSUserCookies extends JSObject
    constructor:->
        super()

    setObject:(value, forKey)->
        $.cookie forKey, encodeURIComponent(value), {expires:365}

    stringForKey:(forKey)->
        ret = decodeURIComponent($.cookie(forKey))
        return ret

    removeObjectForKey:(forKey, domain=location.hostname)->
        path = "/"
        $.removeCookie(forKey, {path: path, domain: domain})

