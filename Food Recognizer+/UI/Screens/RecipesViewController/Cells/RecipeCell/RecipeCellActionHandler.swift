//
//  RecipeCellActionHandler.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

class RecipeCellActionHandler: TableViewAdapterCellActionHandler {
    
    // MARK: - Delegate
    
    weak var storedDelegate: RecipeCellActionHandlerDelegate? {
        return delegate as? RecipeCellActionHandlerDelegate
    }
    
    override func handle(_ action: TableViewAdapterCellAction, cell: TableViewAdapterCell?) {
        guard let recipeCell = cell as? RecipeCell else { return }
        guard let identifier = RecipeCellActionIdentifier(rawValue: action.identifier) else { return }
        
        switch identifier {
        case .overlappingButtonDidTap:
            if let linkString = action.data as? String {
                storedDelegate?.recipeCellOverlappingButtonDidTap(recipeCell, linkString: linkString)
            } else {
                storedDelegate?.recipeCellOverlappingButtonDidTap(recipeCell, linkString: nil)
            }
        }
    }
}
