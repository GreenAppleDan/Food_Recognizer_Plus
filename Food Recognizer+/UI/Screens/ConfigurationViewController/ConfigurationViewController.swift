//
//  ConfigurationViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewController: ViewController<ConfigurationViewControllerPresenter>{
    
    
    override func viewDidLoad() {
        presenter = ConfigurationViewControllerPresenter(delegate: self)
        
        setupNavigationView()
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationView() {
        navigationView?.backButtonIsHidden = true
        navigationView?.set(title: "Configuration")
    }
}


extension ConfigurationViewController: ConfigurationViewControllerProtocol {
    
}
