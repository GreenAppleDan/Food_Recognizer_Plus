//
//  RecipeCellData.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class RecipeCellData: TableViewAdapterItemData {
    let recipe: Recipe
    
    public init(cellIdentifier: String? = nil, recipe: Recipe) {
        self.recipe = recipe
        super.init(cellIdentifier: cellIdentifier)
    }
    
    
}
