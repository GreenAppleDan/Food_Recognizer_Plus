//
//  SimpleTextCollectionViewCellData.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class SimpleTextCollectionViewCellData: CollectionViewAdapterItemData {
    public let labelText: String
    public let adjustFont: Bool
    public let lines: Int
    public let color: UIColor
    
    public init(labelText: String, adjustFont: Bool = false, lines: Int = 1, color: UIColor = .white) {
        self.labelText = labelText
        self.adjustFont = adjustFont
        self.lines = lines
        self.color = color
    }
}
