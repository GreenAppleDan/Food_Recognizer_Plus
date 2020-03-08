//
//  TableViewAdapterUpdateCommandReplace.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdateCommandReplace: TableViewAdapterUpdateCommand {

    let animation: UITableView.RowAnimation
    let itemToReplace: TableViewAdapterItem
    let replaceByItem: TableViewAdapterItem
    
    // MARK: - Initialize
    
    public init(itemToReplace: TableViewAdapterItem,
         replaceByItem: TableViewAdapterItem,
         animation: UITableView.RowAnimation = .fade)
    {
        self.itemToReplace = itemToReplace
        self.replaceByItem = replaceByItem
        self.animation = animation
    }
    
    // MARK: - TableViewAdapterUpdateCommand
    
    public func perform(tableViewAdapter: TableViewAdapter) {
        
        guard let itemIndex = tableViewAdapter.firstIndex(forItem: itemToReplace) else { return }
        
        do {
            try tableViewAdapter.unsafeReplaceFirst(item: itemToReplace,
                                              byItem: replaceByItem)
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        tableViewAdapter.tableView?.reloadRows(at: [IndexPath(row: itemIndex, section: 0)],
                                               with: animation)
    }
    
}

