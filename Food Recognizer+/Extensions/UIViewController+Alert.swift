//
//  UIViewController+Alert.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String, message: String? = nil, completion: (() -> Void)? = nil) {
        
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                if let completion = completion {
                    completion()
                }
            }
        )
        
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func show(_ error: Error) {
        showAlert(title: error.localizedDescription)
    }
 
    public func showPrompt(title: String,
                           message: String? = nil,
                           yesBlock: @escaping ()-> Void) {
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(
            title: "YES",
            style: .destructive,
            handler: { (_) in
                yesBlock()
            }
        )
        
        let noAction = UIAlertAction(
            title: "NO",
            style: .cancel,
            handler: nil
        )
        
        alertViewController.addAction(yesAction)
        alertViewController.addAction(noAction)
        present(alertViewController, animated: true, completion: nil)

    }
}

