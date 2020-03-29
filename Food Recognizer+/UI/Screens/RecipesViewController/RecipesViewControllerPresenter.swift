//
//  RecipesViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

class RecipesViewControllerPresenter: TableViewAdapterPresenter<RecipesViewControllerProtocol>{
    
    func getUniqueRecipes(recipes: [Recipe]?) -> [Recipe]? {
        guard let recipes = recipes else { return nil}
        return Array(Set(recipes))
    }
    
    func processRecipeLinkAndTitle(link: String?, title: String?) {
        guard let link = link else {
            delegate?.showAlert(title: "Sorry, but the recipe is unavailable")
            return
        }
        delegate?.showRecipesWebView(link: link, title: title)
        
    }
    
    
    func saveRecipeToDB(recipe: Recipe?, showTopNotification: Bool) {
        guard let recipeRealm = recipe?.asRecipeRealm() else { return }
        RealmService.addToDB(objects: [recipeRealm])
        if showTopNotification {
        self.showTopNotification(text: "Recipe Saved Successfully!")
        }
    }
    
    func showTopNotification(text: String) {
        let item = CollectionViewCellItemsFactory.simpleTextCollectionViewItem(labelText: text)
        delegate?.showTopNotification(item: item)
    }
    
    func deleteRecipeFromDB(recipe: Recipe?) {
        guard let recipeRealm = recipe?.asRecipeRealm() else { return }
        let predicate = NSPredicate(format: "href = %@", recipeRealm.href)
        RealmService.deleteAllRecordsFromDBWithPredicate(of: RecipeRealm.self, predicate)
        let item = CollectionViewCellItemsFactory.simpleTextCollectionViewItem(labelText: "Recipe Deleted Successfully")
        delegate?.showTopNotification(item: item)
    }
}
