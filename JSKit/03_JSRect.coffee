#*****************************************
# JSRect - Rectangle Class
# Coded by kouichi.sakazaki 2013.03.25
#*****************************************

class JSRect extends JSObject
  constructor:->
    super()
    @origin = new JSPoint()
    @size = new JSSize()
