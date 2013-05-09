##########################################
# JSImagePicker - Image select control class
# Coded by kouichi.sakazaki 2013.04.23
##########################################

class JSImagePicker extends JSScrollView
	constructor:->
		super()
		@_thumbnail_width = 120
		@_thumbnail_height = 120
		@_delegate = null
		@_clipToBounds = true
		@_imageList = new Array()

	viewDidAppear:->
		super()
		@_self.setBackgroundColor(JSColor("gray"))
		@_self.setAlpha(0.0)
		@_self.setClipToBounds(true)
		@_self.addTapGesture(@closeImagePickerView)
		frm = @_parent._frame
		frm.origin.x = 0
		frm.origin.y = 0
		@_self.setFrame(frm)
		fm = new JSFileManager()
		path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
		fm.thumbnailList path, (filelist)=>
			@_self.animateWithDuration 0.2, {alpha:0.9}, =>
				@dispImageList(filelist)

	dispImageList:(_filelist)->
		if (!$(@_viewSelector).length)
			return
		filelist = JSON.parse(_filelist)
		imagelist = filelist['file']
		hnum = parseInt(@_frame.size.width / @_thumbnail_width) - 1
		w = hnum * (@_thumbnail_width+4)+4
		vnum = parseInt(imagelist.length / hnum)+(imagelist.length%hnum!=0)
		if (vnum > 4)
			vnum = 4
		vnum2 = parseInt(@_frame.size.height / (@_thumbnail_height + 4))
		h = vnum * (@_thumbnail_height+4)+4
		h2 = vnum2 * (@_thumbnail_height+4)+4
		x = parseInt(@_frame.size.width / 2 - (w / 2))
		y = -h2
		@imagebase = new JSScrollView(JSRectMake(x, y, w, h + 36))
		@imagebase.setShadow(true)
		@imagebase.setBackgroundColor(JSColor("black"))
		@_self.addSubview(@imagebase)
		
		@listbase = new JSScrollView(JSRectMake(0, 0, w, h + 36))
		@listbase.setClipToBounds(true)
		@listbase.setScroll(true)
		@listbase.setBackgroundColor(JSColor("clearColor"))
		@imagebase.addSubview(@listbase)
		
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
			view.setBackgroundColor(JSColor("clearColor"))
			view.imgfname = imgfname
			view.setUserInteractionEnabled(true)
			view.addTapGesture(@tapImage, 2)
			view.setImage(img)
			
			delbutton = new JSLabel(JSRectMake(4, 0, 16, 16))
			delbutton.setText("×")
			delbutton.setTextColor(JSColor("red"))
			delbutton.setHidden(true)
			delbutton.setTextSize(14)
			delbutton.setBackgroundColor(JSColor("black"))
			delbutton.setAlpha(0.7)
			delbutton.addTapGesture(@deleteImage)
			view.addSubview(delbutton)
			view.bringSubviewToFront(delbutton)
			view.delbutton = delbutton
			
			@listbase.addSubview(view)
			@_imageList.push(view)
			xnum++
			if (xnum == hnum)
				xnum = 0
				ynum++
		
		@imagectrl = new JSView(JSRectMake(0, h, w, 36))
		@imagectrl.setBackgroundColor(JSColor("white"))
		@imagectrl.setAlpha(0.9)
		@imagebase.addSubview(@imagectrl)
		
		@closebutton = new JSButton(JSRectMake(w - 84, 4, 80, 28))
		@closebutton.setButtonTitle("閉じる")
		@closebutton.addTarget(@closeImagePickerView)
		@closebutton.setShadow(true)
		@imagebase.bringSubviewToFront(@closebutton)
		@imagectrl.addSubview(@closebutton)
		
		@editbutton = new JSButton(JSRectMake(4, 4, 80, 28))
		@editbutton.setButtonTitle("編集")
		@editbutton.addTarget(@editImageList)
		@editbutton.setShadow(true)
		@imagebase.bringSubviewToFront(@editbutton)
		@imagectrl.addSubview(@editbutton)
		
		@imagebase.animateWithDuration 0.2, {top:0}

	tapImage:(sender)=>
		@closeImagePickerView()
		if (@_delegate?)
			@_delegate.didPickedImage(sender.imgfname)

	closeImagePickerView:=>
		@imagebase.animateWithDuration 0.2, {top:-@_frame.size.height}, =>
			@_self.animateWithDuration 0.2, {alpha:0.0}, =>
				@imagebase.removeFromSuperview()
				@_self.removeFromSuperview()

	editImageList:(sender)=>
		if (sender._buttonTitle == "編集")
			sender.setButtonTitle("終了")
			count = 0
			for img in @_imageList
				img.removeTapGesture(2)
				img.delbutton.setHidden(false)
				img.number = count++
		else
			sender.setButtonTitle("編集")
			for img in @_imageList
				img.addTapGesture(@tapImage, 2)
				img.delbutton.setHidden(true)
			
	deleteImage:(sender)=>
		sender._parent.animateWithDuration 0.2, {alpha:0.0}, =>
			fname = @_imageList[sender._parent.number].imgfname
			@_imageList.splice(sender._parent.number, 1)
			sender._parent.removeFromSuperview()
			$.post "syslibs/library.php",
				mode: "fileUnlink"
				fpath: fname
			xnum = 0
			ynum = 0
			#hnum = 4
			hnum = parseInt(@_frame.size.width / @_thumbnail_width) - 1
			pos = new JSPoint()
			vnum = parseInt(@_imageList.length / hnum)+(@_imageList.length%hnum!=0)
			count = 0
			for img in @_imageList
				pos.x = xnum * (@_thumbnail_width+4)+4
				pos.y = ynum * (@_thumbnail_height+4)+4
				frm = JSRectMake(pos.x, pos.y, @_thumbnail_width, @_thumbnail_height)
				img.setFrame(frm)
				img.number = count++
				xnum++
				if (xnum == hnum)
					xnum = 0
					ynum++
