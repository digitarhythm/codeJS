#*****************************************
# JSObject - base class of all Object
# Coded by Hajime Oh-yake 2013.03.25
#*****************************************

class JSObject
    constructor:->
        @_self = @
        @_objectID = UniqueID()
