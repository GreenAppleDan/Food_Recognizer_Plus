//
//  EmptySpaceCellData.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class EmptySpaceCellData: TableViewAdapterItemData {
    
    let height: CGFloat?
    let color: UIColor
    
    init(cellIdentifier: String? = nil,
         color: UIColor,
         height: CGFloat? = 44) {
        self.height = height
        self.color = color
        
        if let cellIdentifier = cellIdentifier {
            super.init(cellIdentifier: cellIdentifier)
        }
        else {
            super.init()
        }
    }
    
    // MARK: - Overrides
    
    override public func cellHeight() -> CGFloat {
        if let height = height {
            return height
        }
        return super.cellHeight()
    }
    
}
