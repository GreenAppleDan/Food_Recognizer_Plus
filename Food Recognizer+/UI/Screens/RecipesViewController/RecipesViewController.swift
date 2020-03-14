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
        setNavigationViewTitle("Recipes")
    }
    
    private func reloadItems(){
        let items = RecipesViewControllerItemsFactory.items(recipes)
        
        set(items: items, animated: false)
    }
}


extension RecipesViewController: RecipesViewControllerProtocol {
    
}
