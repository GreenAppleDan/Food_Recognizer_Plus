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
    
    // MARK: - Private. Setup
    
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

}
