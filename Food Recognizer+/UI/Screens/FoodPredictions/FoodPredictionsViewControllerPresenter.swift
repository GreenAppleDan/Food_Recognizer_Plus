//
//  FoodPredictionsViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class FoodPredictionsViewControllerPresenter: TableViewAdapterPresenter<FoodPredictionsViewControllerProtocol> {
    
    private var recipePuppyService: RecipePuppyService

    init(delegate: FoodPredictionsViewControllerProtocol, recipePuppyService: RecipePuppyService) {
        self.recipePuppyService = recipePuppyService
        super.init(delegate: delegate)
    }
    
    
    func getRecipesWithIngridientNames(ingridientNames: [String]) {
        delegate?.startActivityIndicator()
        recipePuppyService.getRecipesWithIngridientNames(names: ingridientNames) { (response) in
            self.delegate?.stopActivityIndicator()
            if let error = response.2 {
                self.delegate?.show(error)
            } else {
                guard let recipes = response.1, recipes.count > 0 else {
                    self.delegate?.showAlert(title: _L("LNG_NO_RECIPES_FOR_SPECIFIED_SET_OF_INGRIDINETS"))
                    return
                }
                self.delegate?.moveToRecipesViewController(recipes)
            }
        }
    }
}
