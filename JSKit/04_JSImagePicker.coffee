#*****************************************
# JSImagePicker - Image select control class
# Coded by kouichi.sakazaki 2013.04.23
#*****************************************

class JSImagePicker extends JSScrollView
	constructor:->
		super()
		@_thumbnail_width = 120
		@_thumbnail_height = 120
		@_clipToBounds = true
		@_imageList = new Array()
		@delegate = null
		@hilight = null

	dispImageList:(_filelist)->
		if (!$(@_viewSelector).length)
			return
		filelist = JSON.parse(_filelist)
		imagelist = filelist['file']
		hnum = parseInt(@_frame.size.width / @_thumbnail_width) - 1
		w = hnum * (@_thumbnail_width+4)+4
		vnum = parseInt(imagelist.length / hnum)+(imagelist.length%hnum!=0)
		if (vnum * @_thumbnail_height + 64 > @_frame.size.height)
			vnum = parseInt(@_frame.size.height / @_thumbnail_height) - 1
		vnum2 = parseInt(@_frame.size.height / (@_thumbnail_height + 4))
		h = vnum * (@_thumbnail_height+4)+4
		h2 = vnum2 * (@_thumbnail_height+4)+4
		x = parseInt(@_frame.size.width / 2 - (w / 2))
		y = -(h2 + 0)
		
		@imagebase = new JSScrollView(JSRectMake(x, y, w, h + 36))
		@imagebase.setShadow(true)
		@imagebase.setBackgroundColor(JSColor("black"))
		@_self.addSubview(@imagebase)
		@_self.bringSubviewToFront(@imagebase)
		
		@listbase = new JSScrollView(JSRectMake(0, 0, w, h + 36))
		@listbase.setClipToBounds(true)
		@listbase.setScroll(true)
		@listbase.setAlpha(0.8)
		@listbase.setBackgroundColor(JSColor("black"))
		@listbase.addTapGesture =>
			if (@hilight?)
				@hilight.delcoverview.setAlpha(0.0)
				@hilight = null
		@imagebase.addSubview(@listbase)
		@imagebase.bringSubviewToFront(@listbase)
			
		@imagectrl = new JSView(JSRectMake(0, h, w, 36))
		@imagectrl.setAlpha(0.8)
		@imagectrl.setBackgroundColor(JSColor("white"))
		@imagebase.addSubview(@imagectrl)
		
		@closebutton = new JSButton(JSRectMake(w - 84, h+4, 80, 28))
		@closebutton.setButtonTitle("閉じる")
		@closebutton.addTarget(@closeImagePickerView)
		@closebutton.setShadow(true)
		@imagebase.addSubview(@closebutton)
		@imagebase.bringSubviewToFront(@closebutton)
		
		@editbutton = new JSButton(JSRectMake(4, h+4, 80, 28))
		@editbutton.setButtonTitle("編集")
		@editbutton.addTarget(@editImageList)
		@editbutton.setShadow(true)
		@imagebase.addSubview(@editbutton)
		@imagebase.bringSubviewToFront(@editbutton)
		
		@imagebase.animateWithDuration 0.2, {top:0}, =>
			xnum = 0
			ynum = 0
			pos = new JSPoint()
			for thumbfname in imagelist
				pos.x = xnum * (@_thumbnail_width+4)+4
				pos.y = ynum * (@_thumbnail_height+4)+4
				path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
				imgfname = thumbfname.replace(/^.*\/(.*?)_s\.(.*)/, path+"/$1.$2")
				img = new JSImage(thumbfname)
				viewfrm = JSRectMake(pos.x, pos.y, @_thumbnail_width, @_thumbnail_height)
				view = new JSImageView(viewfrm)
				view.setContentMode("JSViewContentModeScaleAspectFit")
				view.setBackgroundColor(JSColor("black"))
				view.imgfname = imgfname
				view.imgthumb = thumbfname
				view.setUserInteractionEnabled(true)
				view.addTapGesture(@tapImage, 2)
				view.addTapGesture (sender, e)=>
					if (@hilight?)
						@hilight.delcoverview.setAlpha(0.0)
					@hilight = sender
					sender.delcoverview.setBackgroundColor(JSColor("white"))
					sender.delcoverview.setAlpha(0.5)
					e.stopPropagation()
				view.setImage(img)
				
				delviewfrm = JSRectMake(0, 0, @_thumbnail_width, @_thumbnail_height)
				delcoverview = new JSView(delviewfrm)
				delcoverview.setAlpha(0.0)
				delcoverview.setUserInteractionEnabled(false)
				delcoverview.setBackgroundColor(JSColor("black"))
				view.delcoverview = delcoverview
				view.addSubview(delcoverview)
				delbutton = new JSLabel(JSRectMake(4, 0, 16, 16))
				delbutton.setText("×")
				delbutton.setHidden(true)
				delbutton.setTextColor(JSColor("red"))
				delbutton.setTextSize(14)
				delbutton.setBackgroundColor(JSColor("clearColor"))
				delbutton.addTapGesture(@deleteImage)
				view.addSubview(delbutton)
				view.coverview = delcoverview
				view.delbutton = delbutton
				@listbase.addSubview(view)
				@_imageList.push(view)
				xnum++
				if (xnum == hnum)
					xnum = 0
					ynum++
		
	tapImage:(sender)=>
		@closeImagePickerView()
		if (@delegate?)
			@delegate.didPickedImage(sender.imgfname)

	closeImagePickerView:=>
		@imagebase.animateWithDuration 0.2, {top:-@_frame.size.height}, =>
			@_self.animateWithDuration 0.2, {alpha:0.0}, =>
				@imagectrl.removeFromSuperview()
				@listbase.removeFromSuperview()
				@imagebase.removeFromSuperview()
				@_self.removeFromSuperview()

	editImageList:(sender)=>
		if (sender._buttonTitle == "編集")
			sender.setButtonTitle("終了")
			count = 0
			for img in @_imageList
				img.removeTapGesture(2)
				img.number = count++
				img.delbutton.setHidden(false)
				img.setUserInteractionEnabled(false)
				img.coverview.setBackgroundColor(JSColor("black"))
				img.coverview.animateWithDuration 0.2, {"alpha":0.5}
				@listbase.removeTapGesture()
				@hilight = null
		else
			sender.setButtonTitle("編集")
			for img in @_imageList
				img.addTapGesture(@tapImage, 2)
				img.delbutton.setHidden(true)
				img.coverview.animateWithDuration 0.2, {"alpha":0.0}
				img.setUserInteractionEnabled(true)
				@listbase.addTapGesture =>
					if (@hilight?)
						@hilight.delcoverview.setAlpha(0.0)
						@hilight = null
			
	deleteImage:(sender)=>
		sender._parent.animateWithDuration 0.2, {alpha:0.0}, =>
			fname = @_imageList[sender._parent.number].imgfname
			thumb = @_imageList[sender._parent.number].imgthumb
			@_imageList.splice(sender._parent.number, 1)
			sender._parent.removeFromSuperview()
			$.post "syslibs/library.php",
				mode: "fileUnlink"
				fpath: fname
			$.post "syslibs/library.php",
				mode: "fileUnlink"
				fpath: thumb
			xnum = 0
			ynum = 0
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

	viewDidAppear:->
		super()
		@_self.setBackgroundColor(JSColor("clearColor"))
		@_self.setAlpha(1.0)
		@_self.setClipToBounds(true)
		frm = @_parent._frame
		frm.origin.x = 0
		frm.origin.y = 0
		@_self.setFrame(frm)
		
		@windowbase = new JSView(frm)
		@windowbase.setBackgroundColor(JSColor("black"))
		@windowbase.setAlpha(0.0)
		@windowbase.addTapGesture(@closeImagePickerView)
		@_self.addSubview(@windowbase)
		
		fm = new JSFileManager()
		fm.delegate = fm
		path = JSSearchPathForDirectoriesInDomains("JSPictureDirectory")
		fm.thumbnailList path, (filelist)=>
			@windowbase.animateWithDuration 0.2, {alpha:0.7}, =>
				@dispImageList(filelist)
