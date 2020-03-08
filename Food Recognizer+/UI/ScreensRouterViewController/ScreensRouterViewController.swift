//
//  ScreensRouterViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 04/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ScreensRouterViewController: UIViewController {
    // MARK: - Properties
    var screensFactory: ScreensFactory?
    private weak var mainViewController: MainNavigationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screensFactory = ScreensFactory()
        
        pushMainNavigationViewController()
    }
    // MARK: - Private
    private func pushMainNavigationViewController() {
        guard let screensFactory = screensFactory else { return }
        mainViewController = screensFactory.mainNavigationViewController()
        
        guard let mainViewController = mainViewController else { return }
        
        navigationController?.pushViewController(mainViewController, animated: false)
    }
}
