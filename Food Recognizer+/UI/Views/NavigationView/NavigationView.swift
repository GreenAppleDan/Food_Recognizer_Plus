//
//  NavigationView.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class NavigationView: XibView {
    
    @IBOutlet private weak var view: UIView?
    @IBOutlet private weak var centerLabel: UILabel?
    @IBOutlet private weak var imageWithLeftArrow: UIImageView?
    @IBOutlet private weak var backButton: UIButton?
    @IBOutlet private weak var rightButton: UIButton?
    @IBOutlet private weak var bottomLineView: UIView?
    
    weak var delegate: NavigationViewDelegate?
    
    
    override func awakeFromNib() {
        bottomLineView?.backgroundColor = Colors.silver
    }
    // MARK: - Interface
        
        public var backButtonIsHidden: Bool = false {
            didSet {
                imageWithLeftArrow?.isHidden = self.backButtonIsHidden
                backButton?.isHidden = self.backButtonIsHidden
            }
        }
        
        public var rightButtonIsHidden: Bool = true {
            didSet {
                rightButton?.isHidden = self.rightButtonIsHidden
            }
        }
        
        public var rightButtonTitle: String = "" {
            didSet {
                rightButton?.setTitle(rightButtonTitle, for: .normal)
            }
        }
        
        public func set(title: String?) {
            centerLabel?.text = title
        }
        
        func setLeftButton(title: String?, image: UIImage?) {
            backButton?.setTitle(title, for: .normal)
            backButton?.setImage(image, for: .normal)
            backButton?.isHidden = false
        }
        
        public func setRightButton(title: String?, image: UIImage?) {
            rightButton?.setTitle(title, for: .normal)
            rightButton?.setImage(image, for: .normal)
            rightButton?.isHidden = false
        }
        
        public func setAppearance(color: UIColor = UIColor.black) {
            self.view?.backgroundColor = color
        }
        
        // MARK: - IBActions
    @IBAction func didTapBackButton(_ sender: UIButton) {
        delegate?.navigationViewDidTapBackButton(self)
    }
    
    @IBAction func didTapRightButton(_ sender: UIButton) {
        delegate?.navigationViewDidTapRightButton(self)
    }
    
}
