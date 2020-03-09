//
//  IngridientProbabilityPredictionCellActionHandler.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

class IngridientProbabilityPredictionCellActionHandler: TableViewAdapterCellActionHandler {
    
    // MARK: - Delegate
    weak var storedDelegate: IngridientProbabilityPredictionCellActionHandlerDelegate? {
        return delegate as? IngridientProbabilityPredictionCellActionHandlerDelegate
    }
    
    // MARK: - Interface
    
    override func handle(_ action: TableViewAdapterCellAction, cell: TableViewAdapterCell?) {
        guard let propabilityPredictionCell = cell as? IngridientProbabilityPredictionCell else { return }
        
        guard let identifier = IngridientProbabilityPredictionCellActionIdentifier(rawValue: action.identifier) else { return }
        
        switch identifier {
        case .buttonDidTap:
            guard let cellIdentifier = propabilityPredictionCell.cellData?.cellIdentifier else { return }
            
            storedDelegate?.ingridientProbabilityCellOverlayingbuttonDidTap(propabilityPredictionCell, cellIdentifier: cellIdentifier)
        }
    }
}
