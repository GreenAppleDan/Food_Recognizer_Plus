//
//  CellItemsFactory.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class CellItemsFactory {
    
    static func imageViewItem(cellIdentifier: String? = nil, image: UIImage?) -> TableViewAdapterItem {
        
        let data = ImageViewCellData(cellIdentifier: cellIdentifier, image: image)
        
        let item = TableViewAdapterItem(cellClass: ImageViewCell.self, cellData: data, cellHandler: nil)
        
        return item
    }
    
    static func singleButtonItem(cellIdentifier: String, backgroundColor: UIColor, buttonText: String, buttonTextColor: UIColor, leadingAndTrailingConstraintsValue: CGFloat =  16, isActive: Bool = true) -> TableViewAdapterItem {
        let data = SingleButtonCellData(cellIdentifier: cellIdentifier, backgroundColor: backgroundColor, buttonText: buttonText, buttonTextColor: buttonTextColor, leadingAndTrailingConstraintsValue: leadingAndTrailingConstraintsValue, isActive: isActive)
        
        let item = TableViewAdapterItem(cellClass: SingleButtonCell.self, cellData: data, cellHandler: TableViewAdapterCellActionHandler())
        
        return item
    }
    
    static public func emptySpaceItem(cellIdentifier: String? = nil,
                                      color: UIColor = .clear,
                                      height: CGFloat? = 44) -> TableViewAdapterItem {
        let cellData = EmptySpaceCellData(cellIdentifier: cellIdentifier,
                                          color: color,
                                          height: height)
        let item = TableViewAdapterItem(cellClass: EmptySpaceCell.self, cellData: cellData)
        
        return item
    }
    
}
