//
//  TableViewAdapterItemData.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

open class TableViewAdapterItemData {
    
    // MARK: - Properties
    
    public let cellIdentifier: String
    
    // MARK: - Inits
    
    public init(cellIdentifier: String? = UUID().uuidString) {
        self.cellIdentifier = cellIdentifier ?? UUID().uuidString
    }
    
    // MARK: - Interface
    
    open func cellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func canDelete() -> Bool {
        return false
    }
    
}
