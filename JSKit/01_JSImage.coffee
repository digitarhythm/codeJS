##########################################
# JSImage - image handle class
# Coded by kouichi.sakazaki 2013.03.26
##########################################

class JSImage extends JSObject
	constructor: (imagename) ->
		super()
		if (imagename?)
			@imageNamed(imagename)
	
	imageNamed: (imagefile, flag = false) ->
		if (flag == true)
			path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")+"/.thumb"
		else
			path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
		@_imagepath = path+"/"+imagefile
