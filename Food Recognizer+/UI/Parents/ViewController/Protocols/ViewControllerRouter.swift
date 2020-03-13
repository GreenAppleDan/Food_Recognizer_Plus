//
//  ViewControllerRouter.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public protocol ViewControllerRouter: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func dissmiss(animated: Bool)
}

extension ViewControllerRouter {
    func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }

    func popViewController() {
        popViewController(animated: true)
    }

    func dissmiss() {
        dismiss(animated: true)
    }
}
