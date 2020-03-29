//
//  BaseViewController.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class BaseViewController<T>: ViewController<T> {
    override open func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            if responds(to: #selector(getter: UIView.overrideUserInterfaceStyle)) {
                setValue(UIUserInterfaceStyle.light.rawValue,
                         forKey: "overrideUserInterfaceStyle")
            }
        }
    }
}
