//
//  RecipeRealm.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 15.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import RealmSwift

class RecipeRealm: Object {
    @objc dynamic var title: String? = nil
    @objc dynamic var href: String = UUID().uuidString
    @objc dynamic var ingredients: String? = nil
    @objc dynamic var thumbnail: String? = nil
    @objc dynamic var dateOfAdding: Date = Date()
    
    convenience init(title: String?, href: String, ingridients: String?, thumbnail: String?, dateOfAdding: Date){
        self.init()
        self.title = title
        self.href = href
        self.ingredients = ingridients
        self.thumbnail = thumbnail
        self.dateOfAdding = dateOfAdding
    }
    
    override static func primaryKey() -> String? {
        return "href"
    }
    
    func asSimpleRecipe() -> Recipe {
        return Recipe(title: title, href: href, ingredients: ingredients, thumbnail: thumbnail)
    }
    
}
