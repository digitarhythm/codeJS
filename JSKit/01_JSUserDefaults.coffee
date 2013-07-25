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
			"value": value

	stringForKey:(forKey, action)->
		$.post "syslibs/library.php",
			"mode": "getUserDefaults"
			"forKey": forKey
		, (data)=>
			action(data)

	removeObjectForKey:(forKey)->
		$.post "syslibs/library.php",
			"mode": "removeUserDefaults"
			"forKey": forKey
		, (data)=>
			alert(data)
