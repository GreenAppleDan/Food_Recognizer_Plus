//
//  ConfigurationViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewController: ViewController<ConfigurationViewControllerPresenter>{
    @IBOutlet weak var navigationView: NavigationView!
    
    
    override func viewDidLoad() {
        presenter = ConfigurationViewControllerPresenter(viewController: self, navigationView: navigationView)
        
        presenter?.viewDidLoad()
    }
}
