//
//  Recipe.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

class Recipe: HandyJSON {
    var title: String?
    var href: String?
    var ingredients: String?
    var thumbnail: String?
    
    required init() {}
    
    init(title: String?, href: String?, ingredients: String?, thumbnail: String?) {
        self.title = title
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
    }
    func asRecipeRealm() -> RecipeRealm {
        return RecipeRealm(title: title, href: href ?? "", ingridients: ingredients, thumbnail: thumbnail, dateOfAdding: Date())
    }
}
