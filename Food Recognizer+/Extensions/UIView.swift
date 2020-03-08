//
//  UIView.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

extension UIView {
    func fromNibWithoutConstraints() -> UIView? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else {
            return nil
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        return contentView
    }
    
    @discardableResult func fromNib() -> UIView? {
        guard let contentView = fromNibWithoutConstraints() else { return nil }
        
        let bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: 0
        )
        
        let trailingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: 0
        )
        
        let topConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: 0
        )
        
        let leadingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: 0
        )
        
        addConstraints([bottomConstraint, trailingConstraint, topConstraint, leadingConstraint])
        
        return contentView
    }
    
    public func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                          shadowOpacity: Float = 0.12,
                          shadowOffset: CGSize = CGSize(width: 0, height: 8),
                          shadowRadius: CGFloat = 10) {
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
    
    public func addShadow(color: UIColor?, opacity: Float, offset: CGSize, radius: CGFloat) {
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    public func removeShadow() {
        layer.shadowOpacity = 0.0
    }
}
