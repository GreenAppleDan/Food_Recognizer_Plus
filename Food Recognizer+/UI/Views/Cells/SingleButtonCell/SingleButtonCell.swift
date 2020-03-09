//
//  SingleButtonCell.swift
//  True Photo
//
//  Created by Денис Жукоборский on 16.02.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class SingleButtonCell: TableViewAdapterCell {
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var leading: NSLayoutConstraint?
    @IBOutlet weak var trailing: NSLayoutConstraint?
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button?.layer.cornerRadius = 10
    }
    
    override func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? SingleButtonCellData else { return }
        
        leading?.constant = data.leadingAndTrailingConstraintsValue
        trailing?.constant = data.leadingAndTrailingConstraintsValue
        
        button?.setTitle(data.buttonText, for: .normal)
        button?.backgroundColor = data.backgroundColor
        button?.setTitleColor(data.buttonTextColor, for: .normal)
        
        button?.isEnabled = data.isActive
        
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        notifyDidTap()
    }
}
