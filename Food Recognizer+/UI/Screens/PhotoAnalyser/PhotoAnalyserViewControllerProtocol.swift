//
//  PhotoAnalyserViewControllerProtocol.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

protocol PhotoAnalyserViewControllerProtocol: ViewControllerProtocol {
    func pushFoodPredictionsViewController(predictions: [ClarifaiFoodPrediction])
    func pushRecipesViewController(recipes: [Recipe]?)
    func toggleTabBarInteractable(_ isInteractable: Bool)
    func toggleNavigationViewInteractable(_ isInteractable: Bool)
}
