//
//  CustomTextCellData.swift
//  Food Recognizer+
//
//  Created by dev on 20.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class CustomTextCellData: TableViewAdapterItemData {
    var leftLabelText: String
    var leftLabelColor: UIColor
    var rightLabelText: String?
    var rightLabelColor: UIColor?
    var alternativeImage: UIImage?
    var isArrowHidden: Bool
    
    init(cellIdentifier: String? = nil,
         leftLabelText: String,
         leftLabelColor: UIColor,
         rightLabelText: String?,
         rightLabelColor: UIColor?,
         alternativeImage: UIImage?,
         isArrowHidden: Bool) {
        self.leftLabelText = leftLabelText
        self.leftLabelColor = leftLabelColor
        self.rightLabelText = rightLabelText
        self.rightLabelColor = rightLabelColor
        self.alternativeImage = alternativeImage
        self.isArrowHidden = isArrowHidden
        super.init(cellIdentifier: cellIdentifier)
    }
}
