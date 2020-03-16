//
//  RecipesViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

class RecipesViewControllerPresenter: TableViewAdapterPresenter<RecipesViewControllerProtocol>{
    
    func processRecipeLinkAndTitle(link: String?, title: String?) {
        guard let link = link else {
            delegate?.showAlert(title: "Sorry, but the recipe is unavailable")
            return
        }
        delegate?.showRecipesWebView(link: link, title: title)
        
    }
    
    func saveClickedRecipeToDB(recipe: Recipe?) {
        guard let recipeRealm = recipe?.asRecipeRealm() else { return }
        RealmService.addToDB(objects: [recipeRealm])
    }
    
    func deleteRecipeFromDB(recipe: Recipe?) {
        guard let recipeRealm = recipe?.asRecipeRealm() else { return }
        let predicate = NSPredicate(format: "href = %@", recipeRealm.href)
        RealmService.deleteAllRecordsFromDBWithPredicate(of: RecipeRealm.self, predicate)
    }
}
