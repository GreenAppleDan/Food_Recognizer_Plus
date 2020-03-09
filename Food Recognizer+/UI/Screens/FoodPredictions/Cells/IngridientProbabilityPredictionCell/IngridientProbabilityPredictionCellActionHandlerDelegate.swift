//
//  IngridientProbabilityPredictionCellActionHandlerDelegate.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
protocol IngridientProbabilityPredictionCellActionHandlerDelegate: TableCellActionHandlerDelegate {
    func ingridientProbabilityCellOverlayingbuttonDidTap(_ cell: IngridientProbabilityPredictionCell, cellIdentifier: String)
}
