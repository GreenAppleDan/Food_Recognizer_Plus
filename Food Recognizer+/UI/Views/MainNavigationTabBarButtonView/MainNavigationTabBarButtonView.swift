//
//  MainNavigationTabBarButtonView.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationTabBarButtonView: XibView {
    // MARK: - Delegate
    weak var delegate: MainNavigationTabBarButtonViewDelegate?
    
    // MARK: - Properties
    private var identifier: String?
    private var selected: Bool = false
    
    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var label: UILabel?
    
    // MARK: - Interface
    
    func fill (data: MainNavigationTabBarButtonViewData) {
        identifier = data.identifier
        if let image = data.image {
         imageView?.image = image.withRenderingMode(.alwaysTemplate)
        }
        label?.text = data.labelText
    }
    
    func set(selected: Bool, animated: Bool) {
        self.selected = selected
        UIView.animate(withDuration: animated ? 0.1 : 0) { [weak self] in
            let color = selected ? UIColor(red: 50, green: 200, blue: 50) : UIColor(red: 127, green: 127, blue: 127)
            let transform = selected ? CGAffineTransform(scaleX: 1.25, y: 1.25) : CGAffineTransform(scaleX: 1, y: 1)
            self?.imageView?.tintColor = color
            self?.imageView?.transform = transform
            self?.label?.textColor = color
        }
    }
    
    func isSelected() -> Bool {
        return selected
    }
    
    // MARK: - IBActions
    @IBAction func buttonDidTap(_ sender: UIButton) {
        guard let identifier = identifier else { return }
        delegate?.mainNavigationTabBarViewButtonDidTap(self, identifier: identifier)
    }
}
