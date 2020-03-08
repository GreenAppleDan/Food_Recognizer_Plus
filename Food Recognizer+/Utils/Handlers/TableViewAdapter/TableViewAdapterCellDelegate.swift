//
//  TableViewAdapterCellDelegate.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import Foundation

@objc public protocol TableViewAdapterCellDelegate: class {
    func handle(_ action: TableViewAdapterCellAction, cell: TableViewAdapterCell?)
}
