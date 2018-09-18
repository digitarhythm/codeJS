#*****************************************
# JSTableViewController - table base data manage class
# Coded by Hajime Oh-yake 2013.09.10
#*****************************************

class JSTableViewController extends JSObject
    constructor:(frame)->
        super()
        @_tableViewStyle = "UITableViewStylePlain"
        @_bgColor = JSColor("white")
        @_tableView = new JSTableView(frame)

        @_tableView.delegate = @_self
        @_tableView.dataSource = @_self
