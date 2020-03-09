//
//  EmptySpaceCell.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class EmptySpaceCell: TableViewAdapterCell {
    override public func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? EmptySpaceCellData else { return }
        
        self.backgroundColor = data.color
        contentView.backgroundColor = data.color
    }
}
