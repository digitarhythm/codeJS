#*****************************************
# JSUserValues - User Value in localstorage
# Coded by Hajime Oh-yake 2018.03.04
#*****************************************

class JSUserValues extends JSObject
  constructor:->
    super()
    if (window.localStorage != null)
      @uservalues = window.localStorage
    else if (localStorage != null)
      @uservalues = localStorage

  setObject:(value, key)->
    @uservalues.setItem(key, value)

  objectForKey:(key)->
    if (@uservalues.getItem(key) == null)
      ret = undefined
    else
      ret = @uservalues.getItem(key)
    return ret

  removeObjectForKey:(forKey)->
    @uservalues.removeItem(forKey)

