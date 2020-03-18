//
//  CollectionViewAdapterCell.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

open class CollectionViewAdapterCell: UICollectionViewCell {
    
    public var cellData: CollectionViewAdapterItemData?
    public weak var delegate: CollectionViewAdapterCellDelegate?
    
    open func fill(data: Any?) {
        
    }
    
    open func cellHeight() -> CGFloat {
        return 64
    }
    
    public func notifyDidTap() {
        guard let cellData = cellData else { return }
        let cellDataIdentifier = cellData.cellIdentifier
        
        let action = CollectionViewAdapterCellAction(
            cell: self,
            cellIdentifier: cellDataIdentifier,
            actionIdentifier: CollectionsActionCellsIdentifiers.cellDidTap.rawValue,
            data: cellData)
        
        delegate?.handle(action: action)
    }
}
