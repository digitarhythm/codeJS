#*****************************************
# JSTableView - table base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableView extends JSView
  constructor:(frame)->
    if (!frame?)
      frame = getBounds()
    super(frame)
    @_rowHeight = 32
    @_clipToBounds = true
    @_bgColor = JSColor("clearColor")
    @_scroll = true
    @_titlebarColor = JSColor("#d0d8e0")
    @_titleColor = JSColor("black")
    @_title = "Title Bar"
    @_titleBar = undefined
    @_tableView = undefined
    
    @delegate = null
    @dataSource = null
    @childlist = []
    
    @bounds = getBounds()
    
  setRowHeight:(@_rowHeight)->

  destructor:->
    super()
    @_tableView.removeFromSuperview()
    for obj in @childlist
      JSLog(obj)
      obj.removeFromSuperview()

  addTableView:->
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
      
    @_tableView.setScroll(true)

    # 各セルの内容を返すデリゲートメソッドを呼ぶ
    diff_y = @_rowHeight
    for i in [0...@_dataNum]
      # 各セルの高さを取得して設定する
      if (typeof @delegate.heightForRowAtIndexPath == 'function')
        cellHeight = @delegate.heightForRowAtIndexPath(i)
      else
        cellHeight = @_rowHeight
      
      cell = @dataSource.cellForRowAtIndexPath(i)
      cell._cellnum = i
      cell.delegate = @delegate
      cell._tableview = @
      @childlist.push(cell)

      cell.setFrame(JSRectMake(1, diff_y, @_frame.size.width - 4, cellHeight))
      @_tableView.addSubview(cell)
      diff_y += cellHeight+1
    @_parent.bringSubviewToFront(@_self)
    
  reloadData:->
    if (@_tableView?)
      for obj in @childlist
        obj.removeFromSuperview()
      @addTableView()

  deselectRowAtIndexPath:->
    if (@_tableView?)
      for obj in @childlist
        obj.setBackgroundColor(JSColor("clearColor"))

  viewDidAppear:->
    super()
    if (!@_tableView?)
      if (!@_titleBar?)
        @_titleBar = new JSLabel(JSRectMake(0, 0, @_frame.size.width, @_rowHeight))
        @_titleBar.setText(@_title)
        @_titleBar.setTextAlignment("JSTextAlignmentLeft")
        @_titleBar.setTextSize(11)
        @_titleBar.setBackgroundColor(@_titlebarColor)
        @_titleBar.setTextColor(@_titleColor)
        @_titleBar.setAlpha(0.9)
      frm = JSRectMake(0, 0, @_frame.size.width, @_frame.size.height)
      @_tableView = new JSScrollView(frm)
      @_tableView.setBackgroundColor(@_bgColor)
      @_tableView.setAlpha(@_alpha)
      @_tableView.setCornerRadius(@_cornerRadius)
      @_tableView.setBorderColor(@_borderColor)
      @_tableView.setBorderWidth(@_borderWidth)
      @_self.addSubview(@_tableView)
    @addTableView()
    @_self.addSubview(@_titleBar)
