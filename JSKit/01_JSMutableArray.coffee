##########################################
# JSMutableArray - Dynamic array manage class
# Coded by kouichi.sakazaki 2013.03.31
##########################################

class JSMutableArray extends JSObject
	constructor:(@array = new Array())->
		super()
		
	count:->
		return @array.length
		
	objectAtIndex:(num)->
		return @array[num]

	lastObject:->
		return @array[@array.length-1]
		
	containsObject:(str)->
		return (@array.contains(str) != "" ? true : false)

	addObject:(obj)->
		@array.push(obj)

	insertObject:(obj, index)->
		@array.splice(index,0,obj)
		
	replaceObjectAtIndex:(index, obj)->
		@array.splice(index,obj)

	removeObject:(obj)->
		for i in [0...@array.length-1]	
			if (@array[i] == obj)
				debug("hit!")
				@array.splice(i, 1)
				
	removeObjectAtIndex:(index)->
		@array.splice(index, 1)
	
	removeObjectsInRange:(range)->
		@array.splice(range.location, range.length)
	
	reverse:->
		@array.reverse()