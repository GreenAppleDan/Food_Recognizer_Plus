//
//  ConfigurationViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewControllerPresenter: TableViewAdapterPresenter {
    
    private var navigationView: NavigationView?
    
    init(viewController: UIViewController, navigationView: NavigationView?) {
        self.navigationView = navigationView
        
        super.init(viewController: viewController)
    }
    
    override func viewDidLoad() {
        
        
        
        setupNavigationView()
    }
    
    private func setupNavigationView() {
        navigationView?.backButtonIsHidden = true
        navigationView?.set(title: "Configuration")
    }
}
