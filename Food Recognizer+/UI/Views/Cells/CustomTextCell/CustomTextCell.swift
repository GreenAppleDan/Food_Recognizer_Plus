//
//  CustomTextCell.swift
//  Food Recognizer+
//
//  Created by dev on 20.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class CustomTextCell: TableViewAdapterCell {
    
    @IBOutlet private weak var leftLabel: UILabel?
    @IBOutlet private weak var rightLabel: UILabel?
    @IBOutlet private weak var arrowImageView: UIImageView?
    @IBOutlet private weak var alternativeImageView: UIImageView?
    @IBOutlet private weak var spaceFromRightLabelToArrowImageView: NSLayoutConstraint?
    @IBOutlet private weak var separatorView: UIView?
    
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = Colors.silver
    }

    override func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? CustomTextCellData else { return }
        leftLabel?.text = data.leftLabelText
        leftLabel?.textColor = data.leftLabelColor
        
        if let rightLabelText = data.rightLabelText, let rightLabelTextColor = data.rightLabelColor {
            rightLabel?.text = rightLabelText
            rightLabel?.textColor = rightLabelTextColor
        }
        
        if let alternativeImage = data.alternativeImage {
            alternativeImageView?.image = alternativeImage
            alternativeImageView?.isHidden = false
        } else {
            alternativeImageView?.isHidden = true
        }
        
        arrowImageView?.isHidden = data.isArrowHidden
    }
    
    @IBAction func overlappingButtonDidTap(_ sender: UIButton) {
        notifyDidTap()
    }
}
