//
//  UIViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//
import UIKit

extension UIViewController {
    
    static public func fromStoryboard<T: UIViewController>() -> T {
        let className = String(describing: self)
    
        let storyboard = UIStoryboard.init(name: className, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() as? T {
            return initialViewController
        }
        
        fatalError("Can't initialize view controller \(self)")
    }
    
}
