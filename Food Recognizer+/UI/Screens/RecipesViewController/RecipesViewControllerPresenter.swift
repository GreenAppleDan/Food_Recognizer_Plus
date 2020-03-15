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
            delegate?.showAlert(title: "Sorry, but recipe is unavailable")
            return
        }
        delegate?.showRecipesWebView(link: link, title: title)
        
    }
    
    func saveClickedRecipeToDB(recipe: Recipe?) {
        guard let recipe = recipe?.asRecipeRealm() else { return }
        RealmService.addToDB(objects: [recipe])
    }
}
