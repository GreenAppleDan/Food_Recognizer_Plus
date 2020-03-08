//
//  TableViewAdapterUpdateCommandRemove.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdateCommandRemove: TableViewAdapterUpdateCommand {
    
    // MARK: - Properties
    
    private let animation: UITableView.RowAnimation
    private let items: [TableViewAdapterItem]
    
    // MARK: - Initialize
    
    public init(items: [TableViewAdapterItem], with animation: UITableView.RowAnimation = .fade) {
        self.animation = animation
        self.items = items
    }
    
    // MARK: - TableViewAdapterUpdateCommandRemove
    
    public func perform(tableViewAdapter: TableViewAdapter) {
        
        var indexes: [IndexPath] = []
        
        for item in items {
            guard let itemIndex = tableViewAdapter.firstIndex(forItem: item) else {
                debugPrint("\(String.init(describing: self)) can't remove item, no such item to remove")
                continue
            }
            
            indexes.append(IndexPath(row: itemIndex, section: 0))
        }
        
        for item in items {
            do {
                try tableViewAdapter.unsafeRemoveFirst(item: item)
            } catch {
                debugPrint("\(String.init(describing: self)) can't remove item, no such item to remove")
                continue
            }
        }
        
        tableViewAdapter.tableView?.deleteRows(at: indexes, with: animation)
    }
    
}

