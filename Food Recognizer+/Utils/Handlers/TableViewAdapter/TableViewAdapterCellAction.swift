//
//  TableViewAdapterCellAction.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import Foundation
@objc public class TableViewAdapterCellAction: NSObject {
    
    public let cellIdentifier: String
    @objc public let identifier: String
    @objc public let data: Any?
    
    public init(cellIdentifier: String, identifier: String, data: Any? = nil) {
        self.cellIdentifier = cellIdentifier
        self.identifier = identifier
        self.data = data
    }
    
}
