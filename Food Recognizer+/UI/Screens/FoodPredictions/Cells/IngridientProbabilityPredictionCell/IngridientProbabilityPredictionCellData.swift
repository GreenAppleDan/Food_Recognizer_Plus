//
//  IngridientProbabilityPredictionCellData.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
class IngridientProbabilityPredictionCellData: TableViewAdapterItemData {
    public let ingridientName: String
    public let ingridientProbability: Float
    public var isChosen: Bool
    
    init(cellIdentifier: String? = nil, ingridientName: String, ingridientProbability: Float, isChosen: Bool) {
        self.ingridientName = ingridientName
        self.ingridientProbability = ingridientProbability
        self.isChosen = isChosen
        super.init(cellIdentifier: cellIdentifier)
    }
}
