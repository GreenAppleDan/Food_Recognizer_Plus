//
//  MainNavigationViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationViewControllerPresenter: TableViewAdapterPresenter<MainNavigationViewControllerProtocol> {
    
    override func localizationChanged() {
        super.localizationChanged()
        delegate?.prepareViewControllers()
        delegate?.prepareTabBarView()
    }
}


