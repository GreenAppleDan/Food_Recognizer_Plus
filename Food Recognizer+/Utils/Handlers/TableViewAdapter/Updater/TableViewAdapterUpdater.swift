//
//  TableViewAdapterUpdater.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdater {
    
    // MARK: - Properties
    
    private weak var tableViewAdapter: TableViewAdapter?
    
    private var commands: [TableViewAdapterUpdateCommand] = []
    
    // MARK: - Init
    
    public init(tableViewAdapter: TableViewAdapter) {
        self.tableViewAdapter = tableViewAdapter
    }
    
    // MARK: - Commands interface
    
    public func append(items: [TableViewAdapterItem], animation: UITableView.RowAnimation = .fade) {
        let appendCommand = TableViewAdapterUpdateCommandAppend(items: items, with: animation)
        commands.append(appendCommand)
    }
    
    public func remove(items: [TableViewAdapterItem], animation: UITableView.RowAnimation = .fade) {
        let removeCommand = TableViewAdapterUpdateCommandRemove(items: items, with: animation)
        commands.append(removeCommand)
    }
    
    public func replace(item: TableViewAdapterItem, toItem: TableViewAdapterItem, animation: UITableView.RowAnimation = .fade) {
        let replaceCommand = TableViewAdapterUpdateCommandReplace(itemToReplace: item, replaceByItem: toItem, animation: animation)
        commands.append(replaceCommand)
    }
    
    public func insert(items: [TableViewAdapterItem], after: TableViewAdapterItem, animation: UITableView.RowAnimation = .fade) {
        let insertCommand = TableViewAdapterUpdateCommandInsert(items: items, anchorItem: after, insertAfterAnchorItem: true, animation: animation)
        commands.append(insertCommand)
    }
    
    public func insert(items: [TableViewAdapterItem], before: TableViewAdapterItem, animation: UITableView.RowAnimation = .fade) {
        let insertCommand = TableViewAdapterUpdateCommandInsert(items: items, anchorItem: before, insertAfterAnchorItem: false, animation: animation)
        commands.append(insertCommand)
    }
    
    public func reload(items: [TableViewAdapterItem], animation: UITableView.RowAnimation = .fade) {
        let reloadCommand = TableViewAdapterUpdateCommandReload(items: items, animation: animation)
        commands.append(reloadCommand)
    }
    
    // MARK: - Interface
    
    func performCommands() {
        commands.forEach { command in
            guard let tableViewAdapter = tableViewAdapter else { return }
            
            tableViewAdapter.tableView?.beginUpdates()
            command.perform(tableViewAdapter: tableViewAdapter)
            tableViewAdapter.tableView?.endUpdates()
        }
    }
    
    func clearCommands() {
        commands.removeAll()
    }
    
}
