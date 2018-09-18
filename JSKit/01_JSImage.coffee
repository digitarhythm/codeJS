#*****************************************
# JSImage - image handle class
# Coded by Hajime Oh-yake 2013.03.26
#*****************************************

class JSImage extends JSObject
    constructor: (imagename) ->
        super()
        if (imagename?)
            @imageNamed(imagename)

    imageNamed: (@_imagepath) ->

    imageWriteToSavedPicture:(fname, action)->
        $.post "syslibs/library.php",
        mode: "savePicture"
        imagepath: @_imagepath
        fpath: fname
        ,(ret)=>
            if (action?)
                action(ret)
