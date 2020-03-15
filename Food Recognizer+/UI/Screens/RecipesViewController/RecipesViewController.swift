//
//  RecipesViewController.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class RecipesViewController: ViewController<RecipesViewControllerPresenter> {
    
    // MARK: - Properties
    var screensFactory: ScreensFactory?
    
    var recipes: [Recipe]?
    var state: RecipesViewControllerState = .recipesFromApi
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RecipesViewControllerPresenter(delegate: self)
        
        setupNavigationView()
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private. Setup
    private func setupNavigationView() {
        setNavigationViewRightButtonIsHidden(true)
        switch state {
        case .recipesFromApi: setNavigationViewTitle("Recipes")
        case .recipesFromDB: setNavigationViewTitle("Saved Recipes")
        }
        
    }
    
    private func reloadItems(){
        let items = RecipesViewControllerItemsFactory.items(recipes)
        
        set(items: items, animated: false)
    }
}


extension RecipesViewController: RecipesViewControllerProtocol {
    func showRecipesWebView(link: String?, title: String?) {
        guard let viewController = screensFactory?.webViewController(refference: link, title: title) else { return }
        pushViewController(viewController)
    }
    
    
}

extension RecipesViewController: RecipeCellActionHandlerDelegate {
    func recipeCellOverlappingButtonDidTap(_ recipeCell: RecipeCell, linkString: String?, title: String?) {
        presenter?.saveClickedRecipeToDB(recipe: recipeCell.data?.recipe)
        presenter?.processRecipeLinkAndTitle(link: linkString, title: title)
    }
    
    
}
