//
//  ScreensFactory.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ScreensFactory {
    
    let clarifaiService: ClarifaiService
    let recipePuppyService: RecipePuppyService
    init() {
        clarifaiService = ClarifaiService(apiKey: "d1e9d18edef54ba49a7f031eec6db325")
        recipePuppyService = RecipePuppyService()
    }
    
    
    func mainNavigationViewController() -> MainNavigationViewController {
        let viewController: MainNavigationViewController = .fromStoryboard()
        viewController.screensFactory = self 
        return viewController
    }
    
    func photoAnalyserViewController() -> PhotoAnalyserViewController {
        let viewController: PhotoAnalyserViewController = .fromStoryboard()
        viewController.clarifaiService = clarifaiService
        viewController.screensFactory = self
        return viewController
    }
    
    func configurationViewController() -> ConfigurationViewController {
        let viewController: ConfigurationViewController = .fromStoryboard()
        return viewController
    }
    
    func foodPredictionsViewController(clarifaiPredictions: [ClarifaiFoodPrediction]) -> FoodPredictionsViewController {
        let viewController: FoodPredictionsViewController = .fromStoryboard()
        viewController.clarifaiPredictions = clarifaiPredictions
        viewController.recipePuppyService = recipePuppyService
        viewController.screensFactory = self
        return viewController
    }
    
    func recipesViewController(recipes: [Recipe]?) -> RecipesViewController {
        let viewController: RecipesViewController = .fromStoryboard()
        viewController.screensFactory = self
        viewController.recipes = recipes
        return viewController
    }
    
    func webViewController(refference: String?, title: String?) -> WebViewController {
        let viewController: WebViewController = .fromStoryboard()
        viewController.refference = refference
        viewController.navigationBarTitle = title
        return viewController
    }
}
