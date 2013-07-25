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
			if (typeof(data) == "object")
				data2 = JSON.parse(data)
			else
				data2 = data
			action(data2)

	removeObjectForKey:(forKey)->
		$.post "syslibs/library.php",
			"mode": "removeUserDefaults"
			"forKey": forKey
