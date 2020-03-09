//
//  FoodPredictionsViewControllerPresenterItemsFactory.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

class FoodPredictionsViewControllerPresenterItemsFactory{
    public static func items(predictions: [ClarifaiFoodPrediction]) -> [TableViewAdapterItem] {
        var items = [TableViewAdapterItem]()
        
        for prediction in predictions {
            let item = CellItemsFactory.ingridientProbabilityPredictionItem(ingridientName: prediction.name, ingridientProbability: prediction.score, isChosen: false)
            items.append(item)
        }
        return items
    }
}
