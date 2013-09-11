#*****************************************
# JSTableView - table base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableView extends JSScrollView
	constructor:(frame)->
		if (!frame?)
			frame = getBounds()
		super(frame)
		@_rowHeight = 32
		@_clipToBounds = true
		@_bgColor = JSColor("white")
		@_scroll = true
		@delegate = null
		@dataSource = null
		
	setRowHeight:(@_rowHeight)->
		
	viewDidAppear:->
		super()
		bounds = getBounds()

		# 各セクションに含まれるデータの数を取得する（デリゲートメソッドが無い場合はデータの数は初期値（0））
		if (typeof @dataSource.numberOfRowsInSection == 'function')
			@_dataNum = @dataSource.numberOfRowsInSection()
		else
			@_dataNum = 0
		
		# セクションの数を取得する（デリゲートメソッドが無い場合は初期値（1）のまま）
		if (typeof @dataSource.numberOfSectionsInTableView == 'function')
			@_sectionNum = @dataSource.numberOfSectionsInTableView()
		else
			@_sectionNum = 1
			
		@_tableView = new JSView(JSRectMake(0, 0, bounds.size.width, @_rowHeight * @_dataNum))
		@_tableView.setBackgroundColor(JSColor("blue"))

		dispNum = parseInt(bounds.size.height / @_rowHeight)
			
		# 各セルの内容を返すデリゲートメソッドを呼ぶ
		diff_y = 0
		for i in [0...@_dataNum]
			cell = @dataSource.cellForRowAtIndexPath(i)
			cell._cellnum = i
			cell.delegate = @delegate

			# 各セルの高さを取得して設定する
			if (typeof @delegate.heightForRowAtIndexPath == 'function')
				cellHeight = @delegate.heightForRowAtIndexPath(i)
			else
				cellHeight = @_rowHeight

			frm = JSRectMake(0, diff_y, cell._frame.size.width, cellHeight)

			cell.setFrame(frm)
			@_self.addSubview(cell)
			diff_y += cellHeight+1
		@_parent.bringSubviewToFront(@_self)
