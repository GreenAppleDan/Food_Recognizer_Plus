//
//  ViewControllerProtocol.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public protocol ViewControllerProtocol: class, ActivityIndicatorHandler, AlertHandler  {
    func setNavigationViewTitle(_ title: String, font: UIFont?)
    func setNavigationViewRightButton(title: String?, image: UIImage?)
    func setNavigationViewLeftButton(title: String?, image: UIImage?)
    func setNavigationViewRightButtonIsHidden(_ isHidden: Bool)
    func setNavigationViewLeftButtonIsHidden(_ isHidden: Bool)
    func set(items: [TableViewAdapterItem], reload: Bool, animated: Bool)
    func reloadData(animated: Bool)

}
