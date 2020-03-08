//
//  TableViewAdapterCellActionHandler.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

open class TableViewAdapterCellActionHandler: TableCellActionHandler {
    
    // MARK: - Delegate
    
    private var storedDelegate: TableViewAdapterCellActionHandlerDelegate? {
        return delegate as? TableViewAdapterCellActionHandlerDelegate
    }
    
    // MARK: - Main part
    
    override open func handle(_ action: TableViewAdapterCellAction, cell: TableViewAdapterCell?) {
        guard let tableViewAdapterCell = cell else { return }
        guard let identifier = TableViewAdapterActions(rawValue: action.identifier) else {
            return super.handle(action, cell: tableViewAdapterCell)
        }
        
        switch identifier {
        case .cellDidTap:               cellDidTap(tableViewAdapterCell)
        case .cellBecomeFirstResponder: cellBecomeFirstResponder(tableViewAdapterCell)
        }
    }
    
    // MARK: - Actions
    
    func cellDidTap(_ tableViewAdapterCell: TableViewAdapterCell) {
        guard let cellIdentifier = tableViewAdapterCell.cellData?.cellIdentifier else { return }
        storedDelegate?.tableViewAdapterCellDidTap(tableViewAdapterCell, withIdentifier: cellIdentifier)
    }
    
    func cellBecomeFirstResponder(_ tableViewAdapterCell: TableViewAdapterCell) {
        storedDelegate?.tableViewAdapterCellBecameFirstResponder(tableViewAdapterCell, withIdentifier: tableViewAdapterCell.cellData?.cellIdentifier ?? "")
    }
    
    func defaultAction(_ tableViewAdapterCell: TableViewAdapterCell?, actionIdentifier: String) {
        debugPrint("unhandled action with identifier \(actionIdentifier)")
    }
    
}
