#*****************************************
# JSButton - Button Object
# Coded by Hajime Oh-yake 2013.03.25
#*****************************************

class JSButton extends JSControl
  constructor:(frame = JSRectMake(4, 4, 64, 24))->
    super(frame)
    @_borderColor = JSColor("clearColor")
    @_bgColor = JSColor("clearColor")
    @_buttonTitle = "Button"
    @_style = "JSFormButtonStyleNormal"
    @_textSize = 8
    @_picturedir = 'Media/Picture'
    @delegate = null
    @icon = undefined
    @savedir = ''
    @filter = []
    @selector = undefined

  setIcon:(@icon)->

  setButtonTitle:(title)->
    @_buttonTitle = title
    if ($(@_viewSelector+"_button").length)
      $(@_viewSelector+"_button").val(@_buttonTitle)

  setTextSize:(@_textSize)->
    $(@_viewSelector+"_button").css('font-size', @_textSize+'pt')

  setStyle:(@_style)->
    if ($(@_viewSelector+"_button").length)
      @viewDidAppear()

  setFrame:(frame)->
    super(frame)
    switch @_style
      when "JSFormButtonStyleNormal"
        buttonwidth = frame.size.width
        buttonheight = frame.size.height
        $(@_viewSelector+"_button").css("width", buttonwidth+"px")
        $(@_viewSelector+"_button").css("height", buttonheight+"px")
      when "JSFormButtonStyleImageUpload", "JSFormButtonStyleFileUpload", "JSFormButtonStyleFileUpload"
        buttonwidth = @_frame.size.width
        $(@_viewSelector+"_button").css("width", buttonwidth+"px")

  setIcon:(@icon)->
    $(@_viewSelector+"_button").button {
      icons: {
        primary: @icon
      }
    }
    $(@_viewSelector+"_button").tooltip()

  viewDidAppear:->
    super()

    if ($(@_viewSelector+"_button").length)
      $(@_viewSelector+"_button").remove()

    if ($(@_viewSelector+"_pack").length)
      $(@_viewSelector+"_pack").remove()

    buttonwidth = @_frame.size.width
    buttonheight = @_frame.size.height

    tag = ""
    if (@_style == "JSFormButtonStyleNormal")
      tag += "<div>"
      if (@icon?)
        tag += "<button class='jquery-ui-icon' type='submit' id='"+@_objectID+"_button' style='position:absolute;z-index:1;' title='"+@_buttonTitle+"' />"
      else
        tag += "<input type='submit' id='"+@_objectID+"_button' style='position:absolute;z-index:1;' value='"+@_buttonTitle+"' />"
      tag += "</div>"

    else if (@_style == "JSFormButtonStyleImageUpload")
      tag += "<div id=\""+@_objectID+"_pack\">"
      tag += "<input id=\""+@_objectID+"_file\" type=\"file\" name=\""+@_objectID+"_file\" style=\"display:none;\">"
      tag += "<button class='jquery-ui-icon' type=\"submit\" id=\""+@_objectID+"_button\" style=\"position:absolute;z-index:1;\" title=\"image upload\" onClick=\"$('#"+@_objectID+"_file').click();\" />"
      tag += "</div>"
      @icon = "ui-icon-circle-arrow-n"

    else if (@_style == "JSFormButtonStyleFileUpload")
      tag += "<div id=\""+@_objectID+"_pack\">"
      tag += "<input id=\""+@_objectID+"_file\" type=\"file\" name=\""+@_objectID+"_file\" style=\"display:none;\">"
      tag += "<button class='jquery-ui-icon' type=\"submit\" id=\""+@_objectID+"_button\" style=\"position:absolute;z-index:1;\" title=\"file upload\" onClick=\"$('#"+@_objectID+"_file').click();\" />"
      tag += "</div>"
      @icon = "ui-icon-circle-arrow-n"

    else if (@_style == "JSFormButtonStyleFileSelect")
      tag += "<div id=\""+@_objectID+"_pack\">"
      tag += "<input id=\""+@_objectID+"_file\" type=\"file\" name=\""+@_objectID+"_file\" style=\"display:none;\" multiple>"
      if (@icon?)
        tag += "<button class='jquery-ui-icon' type=\"submit\" id=\""+@_objectID+"_button\" style=\"position:absolute;z-index:1;\" title=\"file select\" onClick=\"$('#"+@_objectID+"_file').click();\" />"
        #@icon = "ui-icon-folder-open"
      else
        tag += "<input type='submit' id='"+@_objectID+"_button' style='position:absolute;z-index:1;' value='"+@_buttonTitle+"' onClick=\"$('#"+@_objectID+"_file').click();\" />"
      tag += "</div>"

    $(@_viewSelector).append(tag)

    if (@_style == "JSFormButtonStyleFileUpload")
      $(@_viewSelector+"_file").change =>
        if (typeof @delegate.didFileUploadStart == 'function')
          @delegate.didFileUploadStart()
        $(@_viewSelector+"_file").upload "syslibs/library.php",
          mode: "uploadfile"
          savedir: @savedir
          filter: @filter
          key: @_objectID+"_file"
        , (res) =>
          if (typeof @delegate.didFileUpload == 'function')
            @delegate.didFileUpload(res)
          $(@_viewSelector+"_file").val("")
        , "json"

    else if (@_style == "JSFormButtonStyleImageUpload")
      $(@_viewSelector+"_file").change =>
        if (typeof @delegate.didUploadStart == 'function')
          @delegate.didUploadStart()
        $(@_viewSelector+"_file").upload "syslibs/library.php",
          mode: "uploadimage"
          key: @_objectID+"_file"
        , (res) =>
          if (typeof @delegate.didImageUpload == 'function')
            @delegate.didImageUpload(res)
          $(@_viewSelector+"_file").val("")
          $.post "syslibs/library.php",
            mode:"createThumbnail"
            path:@_picturedir
        , "json"

    else if (@_style == "JSFormButtonStyleFileSelect")
      $(@_viewSelector+"_file").change (e)=>
        file = e.target.files
        #reader = new FileReader()
        #reader.readAsText(file[0])
        #reader.onload = (e2)=>
        #  if (@selector?)
        #    @selector(reader.result)
        @selector(file)
        $(@_viewSelector+"_file").val("")

    $(@_viewSelector).css("overflow", "visible")
    $(@_viewSelector+"_button").css("overflow", "hidden")
    $(@_viewSelector+"_button").css("position", "absolute")
    $(@_viewSelector+"_button").css("background-color", "transparent")
    $(@_viewSelector+"_button").css("font-size", @_textSize+"pt")
    $(@_viewSelector+"_button").css("width", buttonwidth+"px")
    $(@_viewSelector+"_button").css("height", buttonheight+"px")

    if (@icon?)
      $(@_viewSelector+"_button").button {
        icons: {
          primary: @icon
        }
      }
      #$(@_viewSelector+"_button").tooltip()
    else
      $(@_viewSelector+"_button").button()

