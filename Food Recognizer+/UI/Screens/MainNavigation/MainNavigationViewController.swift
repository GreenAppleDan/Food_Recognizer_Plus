//
//  MainNavigationViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationViewController: ViewController<MainNavigationViewControllerPresenter> {
    
    // MARK: - Properties
    private weak var pageViewController: UITabBarController?
    var screensFactory: ScreensFactory?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mainNavigationTabBarView: MainNavigationTabBarView?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainNavigationViewControllerPresenter(viewController: self, pageViewController: pageViewController, screensFactory: screensFactory, mainNavigationTabBarView: mainNavigationTabBarView)
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.viewDidLayoutSubviews()
        }
    }
    
    
    // MARK: - Preparing for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embed" {
            self.pageViewController = segue.destination as? UITabBarController
        }
    }
}
