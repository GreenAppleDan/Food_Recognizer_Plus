//
//  FoodPredictionsViewControllerProtocol.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

protocol FoodPredictionsViewControllerProtocol: ViewControllerProtocol {
    func moveToRecipesViewController(_ recipes: [Recipe]?)
}
