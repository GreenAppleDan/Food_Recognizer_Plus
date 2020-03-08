//
//  TableViewAdapterUpdateCommandInsert.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapterUpdateCommandInsert: TableViewAdapterUpdateCommand {
    
    private let animation: UITableView.RowAnimation
    private let items: [TableViewAdapterItem]
    private let anchorItem: TableViewAdapterItem
    private let insertAfterAnchorItem: Bool
    
    // MARK: - Initialize
    
    public init(items: [TableViewAdapterItem],
                 anchorItem: TableViewAdapterItem,
                 insertAfterAnchorItem: Bool = true,
                 animation: UITableView.RowAnimation = .fade) {
        self.items = items
        self.anchorItem = anchorItem
        self.insertAfterAnchorItem = insertAfterAnchorItem
        self.animation = animation
    }
    
    // MARK: - TableViewAdapterUpdateCommand
    
    public func perform(tableViewAdapter: TableViewAdapter) {
        guard let anchorItemIndex = tableViewAdapter.firstIndex(forItem: anchorItem) else { return }
        
        var indexes: [IndexPath] = []
        
        do {
            try tableViewAdapter.unsafeInsert(items: items,
                                              afterItem: anchorItem,
                                              insertAfterAnchorItem: insertAfterAnchorItem)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        var insertIndex = insertAfterAnchorItem ? anchorItemIndex + 1 : anchorItemIndex
        items.forEach { _ in
            indexes.append(IndexPath(row: insertIndex, section: 0))
            insertIndex += 1
        }
        
        tableViewAdapter.tableView?.insertRows(at: indexes, with: animation)
    }
}

