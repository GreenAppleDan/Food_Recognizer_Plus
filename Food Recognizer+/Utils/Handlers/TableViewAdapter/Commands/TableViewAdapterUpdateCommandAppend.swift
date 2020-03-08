//
//  TableViewAdapterUpdateCommandAppend.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdateCommandAppend: TableViewAdapterUpdateCommand {
    
    // MARK: - Properties
    
    private let animation: UITableView.RowAnimation
    private let items: [TableViewAdapterItem]
    
    // MARK: - Initialize
    
    public init(items: [TableViewAdapterItem],
                with animation: UITableView.RowAnimation = .fade) {
        self.items = items
        self.animation = animation
    }
    
    // MARK: - TableViewAdapterUpdateCommand
    
    public func perform(tableViewAdapter: TableViewAdapter) {
        
        var indexes: [IndexPath] = []
        
        for item in items {
            indexes.append(IndexPath(row: tableViewAdapter.itemsCount, section: 0))
            tableViewAdapter.unsafeAdd(item: item)
        }
        
        tableViewAdapter.tableView?.insertRows(at: indexes, with: animation)
    }
}

