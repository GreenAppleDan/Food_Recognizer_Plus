//
//  MainNavigationTabBarViewDelegate.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import Foundation

protocol MainNavigationTabBarViewDelegate: class {
    func mainNavigationTabBarView(_ view: MainNavigationTabBarView, itemDidTapWithIdentifier identifier: String)
}
