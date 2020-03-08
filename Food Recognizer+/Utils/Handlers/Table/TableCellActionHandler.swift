//
//  TableCellActionHandler.swift
//  True Photo
//
//  Created by Денис Жукоборский on 18.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

open class TableCellActionHandler: TableViewAdapterCellDelegate {
    
    // MARK: - Delegate
    
    public weak var delegate: TableCellActionHandlerDelegate?
    
    // MARK: - Inits part
    
    public init() {}
    
    // MARK: - Main part
    
    open func handle(_ action: TableViewAdapterCellAction, cell: TableViewAdapterCell?) {}
}
