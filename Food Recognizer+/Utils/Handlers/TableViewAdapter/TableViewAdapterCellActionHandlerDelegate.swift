//
//  TableViewAdapterCellActionHandlerDelegate.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import Foundation

public protocol TableViewAdapterCellActionHandlerDelegate: TableCellActionHandlerDelegate {
    func tableViewAdapterCellDidTap(_ tableViewAdapterCell: TableViewAdapterCell, withIdentifier identifier: String)
    func tableViewAdapterCellBecameFirstResponder(_ tableViewAdapterCell: TableViewAdapterCell, withIdentifier identifier: String)
}

extension TableViewAdapterCellActionHandlerDelegate {
    public func tableViewAdapterCellBecameFirstResponder(_ tableViewAdapterCell: TableViewAdapterCell,
                                                         withIdentifier identifier: String) {
        
    }
}
