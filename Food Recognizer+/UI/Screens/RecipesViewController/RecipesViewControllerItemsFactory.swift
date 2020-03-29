//
//  RecipesViewControllerItemsFactory.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class RecipesViewControllerItemsFactory {
    
    static func items(_ recipes: [Recipe]?) -> [TableViewAdapterItem] {
        var items = [TableViewAdapterItem]()
        
        if let recipes = recipes {
            for recipe in recipes.sorted(by: {$0.title ?? "" < $1.title ?? ""}) {
                items.append(CellItemsFactory.recipeItem(recipe: recipe))
            }
        }
        
        return items
    }
}
