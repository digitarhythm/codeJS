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
		for value in @array
			if (str == value)
				return true;
		return false;

	addObject:(obj)->
		@array.push(obj)

	insertObject:(obj, index)->
		@array.splice(index,0,obj)
		
	replaceObjectAtIndex:(index, obj)->
		@array.splice(index, 1, obj)

	removeObject:(obj)->
		for i in [0...@array.length-1]	
			if (@array[i] == obj)
				@array.splice(i, 1)
	
	removeAllObjects:->
		@array.splice(0, @array.length)
				
	removeObjectAtIndex:(index)->
		@array.splice(index, 1)
	
	removeObjectsInRange:(range)->
		@array.splice(range.location, range.length)
	
	reverse:->
		@array.reverse()