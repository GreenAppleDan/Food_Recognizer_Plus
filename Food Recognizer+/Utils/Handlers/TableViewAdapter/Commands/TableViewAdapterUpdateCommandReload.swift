//
//  TableViewAdapterUpdateCommandReload.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdateCommandReload: TableViewAdapterUpdateCommand {
    
    // MARK: - Properties
    
    public let animation: UITableView.RowAnimation
    public let items: [TableViewAdapterItem]
    
    // MARK: - Init
    
    public init(items: [TableViewAdapterItem], animation: UITableView.RowAnimation) {
        self.items = items
        self.animation = animation
    }
    
    // MARK: - Interface
    
    public func perform(tableViewAdapter: TableViewAdapter) {
        let indexPaths: [IndexPath] = self.items.compactMap { item in
            guard let index = tableViewAdapter.firstIndex(forItem: item) else { return nil }
            
            return IndexPath(row: index, section: 0)
        }
        
        tableViewAdapter.tableView?.reloadRows(at: indexPaths, with: animation)
    }
    
}

