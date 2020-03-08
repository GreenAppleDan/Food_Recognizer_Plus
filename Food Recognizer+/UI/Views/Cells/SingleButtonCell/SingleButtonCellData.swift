//
//  SingleButtonCellData.swift
//  True Photo
//
//  Created by Денис Жукоборский on 16.02.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class SingleButtonCellData: TableViewAdapterItemData {
    
    var backgroundColor: UIColor
    var buttonText: String
    var buttonTextColor: UIColor
    var leadingAndTrailingConstraintsValue: CGFloat
    
    init(cellIdentifier: String, backgroundColor: UIColor, buttonText: String, buttonTextColor: UIColor, leadingAndTrailingConstraintsValue: CGFloat) {
        self.backgroundColor = backgroundColor
        self.buttonText = buttonText
        self.buttonTextColor = buttonTextColor
        self.leadingAndTrailingConstraintsValue = leadingAndTrailingConstraintsValue
        super.init(cellIdentifier: cellIdentifier)
    }
}
