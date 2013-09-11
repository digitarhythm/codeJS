#*****************************************
# JSTableViewController - table base data manage class
# Coded by kouichi.sakazaki 2013.09.10
#*****************************************

class JSTableViewController extends JSObject
	constructor:->
		super()
		@_tableViewStyle = "UITableViewStylePlain"
		@_bgColor = JSColor("white")
		@_tableView = new JSTableView()
		
		@_tableView.delegate = @_self
		@_tableView.dataSource = @_self
		
	numberOfRowsInSection:->
		return 0

	cellForRowAtIndexPath:(i)->
		cell = new JSTableViewCell()
		return cell
	