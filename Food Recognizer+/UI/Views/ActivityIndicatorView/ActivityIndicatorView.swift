//
//  ActivityIndicatorView.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public class ActivityIndicatorView: XibView {
    
    // MARK: - Timeout Constant
    
    static let stopActivityIndicatorTimeout: Double = 20
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var activityIndicatorBackgroundView: UIView?
    
    // MARK: - Interface
    
    public func startActivityIndicator(disableTimeout: Bool = true, bgAlpha: CGFloat = 0.2, color: UIColor = .white) {
         
        activityIndicatorBackgroundView?.alpha = bgAlpha
        activityIndicatorView?.color = color
        self.alpha = 1
        activityIndicatorView?.startAnimating()
        
        if !disableTimeout {
            main(delay: type(of: self).stopActivityIndicatorTimeout) { [weak self] in
                self?.stopActivityIndicator()
            }
        }
    }
    
    public func setBackgroundColorToBackgroundView(color: UIColor) {
        activityIndicatorBackgroundView?.backgroundColor = color
    }
    
    public func stopActivityIndicator() {
        self.alpha = 0
        activityIndicatorView?.stopAnimating()
    }
    
    override public func loadedFromNib() {
        super.loadedFromNib()
        stopActivityIndicator()
    }
    
    // MARK: - Pass Touch
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view?.superview == self, self.alpha == 0 {
            return nil
        }
        
        return view
    }
    
}
