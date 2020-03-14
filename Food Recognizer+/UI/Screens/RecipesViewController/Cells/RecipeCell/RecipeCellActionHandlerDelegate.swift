//
//  RecipeCellActionHandlerDelegate.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

protocol RecipeCellActionHandlerDelegate: TableCellActionHandlerDelegate{
    func recipeCellOverlappingButtonDidTap(_ recipeCell: RecipeCell, linkString: String?, title: String?)
}
