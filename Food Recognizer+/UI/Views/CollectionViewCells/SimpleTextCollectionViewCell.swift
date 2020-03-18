//
//  SimpleTextCollectionViewCell.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class SimpleTextCollectionViewCell: CollectionViewAdapterCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var label: UILabel?
    
    
    override func fill(data: Any?) {
        guard let data = data as? SimpleTextCollectionViewCellData else { return }
        self.contentView.backgroundColor = Colors.black.withAlphaComponent(0.7)
        self.contentView.layer.cornerRadius = 16
        self.contentView.addShadow(shadowColor: Colors.black.cgColor,
                                   shadowOffset: CGSize(width: 0, height: 2),
                                   shadowRadius: 8)
        label?.textColor = data.color
        
        label?.text = data.labelText
        if data.adjustFont {
            label?.adjustsFontSizeToFitWidth = true
            label?.minimumScaleFactor = 0.3
        }
        label?.numberOfLines = data.lines
    }
}
