//
//  AlertHandler.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

public protocol AlertHandler {
    func showAlert(title: String, message: String?, completion: (() -> Void)?)
    func show(_ error: Error)
    
    func showPrompt(title: String,  message: String?, yesBlock: @escaping ()-> Void)
}


extension AlertHandler {
    func showAlert(title: String) {
        showAlert(title: title, message: nil, completion: nil)
    }
    
    func showPrompt(title: String, yesBlock: @escaping ()-> Void) {
        showPrompt(title: title,  message: nil, yesBlock: yesBlock)
    }
}
