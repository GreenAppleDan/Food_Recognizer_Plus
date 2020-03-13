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
        recipePuppyService.getRecipesWithIngridientNames(names: ingridientNames) { (response) in
            if let error = response.2 {
                self.delegate?.show(error)
            } else if let recipes = response.1 {
                //Переходим на другую вьюшку
                print(recipes)
            }
        }
    }
}
