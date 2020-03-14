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
    let imageLoaderItem: ImageLoaderItem
    
    public init(cellIdentifier: String? = nil, recipe: Recipe, imageLoaderItem: ImageLoaderItem) {
        self.recipe = recipe
        self.imageLoaderItem = imageLoaderItem
        super.init(cellIdentifier: cellIdentifier)
    }
    
    
}
