##########################################
# JSImagePicker - Image select control class
# Coded by kouichi.sakazaki 2013.04.23
##########################################

class JSImagePicker extends JSScrollView
	constructor:(frame)->
		super()
		@_thumbnail_width = 120
		@_thumbnail_height = 120
		@_delegate = null

	viewDidAppear:->
		super()
		@_self.setBackgroundColor(JSColor("clearColor"))
		@_self.addTapGesture(@closeImagePickerView)
		frm = @_parent._frame
		frm.origin.x = 0
		frm.origin.y = 0
		@_self.setFrame(frm)
		fm = new JSFileManager()
		path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
		fm.thumbnailList path, (filelist)=>
			@dispImageList(filelist)

	dispImageList:(_filelist)->
		filelist = JSON.parse(_filelist)
		imagelist = filelist['file']
#		hnum = parseInt(@_frame.size.width / (@_thumbnail_width + 4))
		hnum = 4
		vnum = parseInt(imagelist.length / hnum)+(imagelist.length%hnum!=0)
		vnum2 = parseInt(@_frame.size.height / (@_thumbnail_height + 4))
		w = hnum * (@_thumbnail_width+4)+4
		h = vnum * (@_thumbnail_height+4)+4
		h2 = vnum2 * (@_thumbnail_height+4)+4
		x = parseInt(@_frame.size.width / 2 - (w / 2))
		y = -@_frame.size.height
		@imagebase = new JSScrollView(JSRectMake(x, y, w, h2 + 36))
		@imagebase.setShadow(true)
		@imagebase.setBackgroundColor(JSColor("black"))
		@_self.addSubview(@imagebase)
		
		@listbase = new JSScrollView(JSRectMake(0, 0, w, h2 + 36))
		@listbase.setClipToBounds(true)
		@listbase.setScroll(true)
		@listbase.setBackgroundColor(JSColor("clearColor"))
		@imagebase.addSubview(@listbase)
		
		@imagelistview = new JSView(JSRectMake(0, 0, w, h))
		@imagelistview.setBackgroundColor(JSColor("clearColor"))
		@listbase.addSubview(@imagelistview)
		
		xnum = 0
		ynum = 0
		pos = new JSPoint()
		for thumbfname in imagelist
			pos.x = xnum * (@_thumbnail_width+4)+4
			pos.y = ynum * (@_thumbnail_height+4)+4
			path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
			imgfname = thumbfname.replace(/^.*\/(.*?)_s\.(.*)/, path+"/$1.$2")
			img = new JSImage(thumbfname)
			view = new JSImageView(JSRectMake(pos.x, pos.y, @_thumbnail_width, @_thumbnail_height))
			view.setContentMode("JSViewContentModeScaleAspectFit")
#			view.setBackgroundColor(JSColor("clearColor"))
#			view.setShadow(true)
			view.imgfname = imgfname
			view.setUserInteractionEnabled(true)
			view.addTapGesture(@tapImage, 2)
			view.setImage(img)
			@imagelistview.addSubview(view)
			xnum++
			if (xnum == hnum)
				xnum = 0
				ynum++
		
		@imagectrl = new JSView(JSRectMake(0, h2, w, 36))
		@imagectrl.setBackgroundColor(JSColor("white"))
		@imagectrl.setAlpha(0.8)
		@imagebase.addSubview(@imagectrl)
		
		@closebutton = new JSButton(JSRectMake(w - 84, 4, 80, 28))
		@closebutton.setButtonTitle("close")
		@closebutton.addTarget(@closeImagePickerView)
		@imagectrl.addSubview(@closebutton)
		
		@imagebase.animateWithDuration 0.2, {top:0}

	tapImage:(sender)=>
		@closeImagePickerView()
		if (@_delegate?)
			@_delegate.didPickedImage(sender.imgfname)

	closeImagePickerView:=>
		@imagebase.animateWithDuration 0.2, {top:-@_frame.size.height}, =>
			@imagelistview.removeFromSuperview()
			@imagebase.removeFromSuperview()
			@_self.removeFromSuperview()
