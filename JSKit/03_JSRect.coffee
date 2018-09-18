#*****************************************
# JSRect - Rectangle Class
# Coded by Hajime Oh-yake 2013.03.25
#*****************************************

class JSRect extends JSObject
    constructor:->
        super()
        @origin = new JSPoint()
        @size = new JSSize()
