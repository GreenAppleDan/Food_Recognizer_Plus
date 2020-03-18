//
//  CollectionViewCellItemsFactory.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class CollectionViewCellItemsFactory {
    static func simpleTextCollectionViewItem(labelText: String, adjustFont: Bool = true, lines: Int = 1, color: UIColor = Colors.white) -> TopNotificationsControllerCollectionViewItem {
        let data = SimpleTextCollectionViewCellData(labelText: labelText, adjustFont: adjustFont, lines: lines, color: color)
        let item = TopNotificationsControllerCollectionViewItem(cellClass: SimpleTextCollectionViewCell.self, cellData: data, cellBundleIdentifier: nil)
        return item
    }
}
