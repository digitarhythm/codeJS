#*****************************************
# JSUserDefaults - User Default Class
# Coded by kouichi.sakazaki 2013.07.24
#*****************************************

class JSUserDefaults extends JSObject
  constructor:->
    super()

  setObject:(value, forKey)->
    $.post "syslibs/library.php",
      "mode": "setUserDefaults"
      "forKey": forKey
      "value": JSON.stringify(value)

  stringForKey:(forKey, action)->
    $.post "syslibs/library.php",
      "mode": "getUserDefaults"
      "forKey": forKey
    , (data)=>
      if (data != "")
        data2 = JSON.parse(data)
      else
        data2 = ""
      action(data2)

  removeObjectForKey:(forKey)->
    $.post "syslibs/library.php",
      "mode": "removeUserDefaults"
      "forKey": forKey
