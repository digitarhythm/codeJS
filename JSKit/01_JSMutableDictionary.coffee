##########################################
# JSMutableDictionary HASH list manage class
# Coded by kouichi.sakazaki 2013.04.02
##########################################

class JSMutableDictionary extends JSObject
	constructor:(@dictionary = {})->
		
	removeAllObjects:->
		@dictionary = {}
		
	removeObjectForKey:(key)->
		delete @dictionary.key
		
	setObject:(object, key)->
		@dictionary[key] = object
		
	objectForKey:(key)->
		return @dictionary[key]
		
	count:->
		num = 0
		for d of @dictionary
			num++
		return num
		
	allKeys:->
		ret = new Array()
		for key of @dictionary
			ret.push(key)
		return ret

	allValues:->
		ret new Array()
		for key, val of @dictionary
			ret.push(val)
		return ret

