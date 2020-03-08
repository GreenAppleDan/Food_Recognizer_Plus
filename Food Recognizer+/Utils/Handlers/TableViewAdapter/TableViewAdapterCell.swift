//
//  TableViewAdapterCell.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

open class TableViewAdapterCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var cellData: TableViewAdapterItemData?
    open var handler: TableViewAdapterCellActionHandler?
    public weak var delegate: TableViewAdapterCellDelegate?
    
    // MARK: - Life-Cycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCommonProperties()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCommonProperties()
    }
    
    // MARK: - Common Initialization
    
    private func setupCommonProperties() {
        self.selectionStyle = .none
    }
    
    // MARK: - Interface
    
    open func fill(data: TableViewAdapterItemData?) {
        
    }
    
    // MARK: - Notifications
    
    public func notifyDidTap() {
        notify(actionWithIdentifier: CellsActionIdentifiers.cellDidTap.rawValue)
    }
    
    public func notify(actionWithIdentifier actionIdentifier: String, data: Any? = nil) {
        guard let cellData = cellData else { return }
        let cellIdentifier = cellData.cellIdentifier
        
        let action = TableViewAdapterCellAction(
            cellIdentifier: cellIdentifier,
            identifier: actionIdentifier,
            data: data
        )
        delegate?.handle(action, cell: self)
    }
    
}

