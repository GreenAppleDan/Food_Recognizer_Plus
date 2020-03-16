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
    
    // MARK: - tableViewAdapterDelegate. Overriding
    override func tableViewAdapterNeedsActionsForCellEditing(adapter: TableViewAdapter, cell: TableViewAdapterCell) -> [UITableViewRowAction]? {
        guard let cellData = cell.cellData as? RecipeCellData, state == .recipesFromApi else { return nil }
            let saveAction = UITableViewRowAction(style: .normal, title: "Save") { _, _ in
                self.presenter?.saveClickedRecipeToDB(recipe: cellData.recipe)
            }
        return [saveAction]
    }
    
    override func tableViewAdapterUserDidDeleteCell(adapter: TableViewAdapter, cell: TableViewAdapterCell?) {
        let cellData = cell?.cellData as? RecipeCellData
        presenter?.deleteRecipeFromDB(recipe: cellData?.recipe)
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
