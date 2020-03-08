//
//  ScreensFactory.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ScreensFactory {
    init() {
    }
    
    
    func mainNavigationViewController() -> MainNavigationViewController {
        let viewController: MainNavigationViewController = .fromStoryboard()
        viewController.screensFactory = self 
        return viewController
    }
    
    func photoAnalyserViewController() -> PhotoAnalyserViewController {
        let viewController: PhotoAnalyserViewController = .fromStoryboard()
        return viewController
    }
    
    func configurationViewController() -> ConfigurationViewController {
        let viewController: ConfigurationViewController = .fromStoryboard()
        return viewController
    }
}
