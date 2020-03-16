//
//  PhotoAnalyserViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class PhotoAnalyserViewControllerPresenter: TableViewAdapterPresenter<PhotoAnalyserViewControllerProtocol> {
    
    private var clarifaiService: ClarifaiService
    
    init(delegate: PhotoAnalyserViewControllerProtocol, clarifaiService: ClarifaiService) {
        self.clarifaiService = clarifaiService
        super.init(delegate: delegate)
    }
    
    
    func getFoodPredictions(for image: UIImage) {
        clarifaiService.getFoodPredictions(from: image) { (result) in
            self.delegate?.stopActivityIndicator()
            if let error = result.1 {
                self.delegate?.show(error)
            } else if let predictions = result.0 {
                self.delegate?.pushFoodPredictionsViewController(predictions: predictions)
            }
        }
    }
    
    func getRecipesFromDB() -> [Recipe]? {
        return RealmService.getAllRecordsFromDB(of: RecipeRealm.self)?.map{ $0.asSimpleRecipe()}
        
    }
    
    func handleRightButtonNavigationViewTap() {
        delegate?.pushRecipesViewController(recipes: getRecipesFromDB()?.reversed())
    }
    
}
