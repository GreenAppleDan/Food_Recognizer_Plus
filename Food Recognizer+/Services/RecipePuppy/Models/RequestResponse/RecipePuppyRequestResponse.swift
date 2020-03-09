//
//  RecipePuppyRequestResponse.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

struct RecipePuppyRequestResponse: HandyJSON {
    // MARK: - Properties
    
    var recipes: [Recipe]?
    
    mutating func mapping(mapper: HelpingMapper) {
        
        mapper <<<
           recipes <-- ("results", TransformOf<[Recipe], [[String : Any]]>(fromJSON: { response -> [Recipe]? in
            guard let rawRecipes = response else {
                return nil
            }
            
            var recipes: [Recipe] = []
            
            for rawRecipe in rawRecipes {
                guard let recipe = Recipe.deserialize(from: rawRecipe) else { continue }
                recipes.append(recipe)
            }
            return recipes
            
        }, toJSON: { _ in return nil }))
        
    }
}
