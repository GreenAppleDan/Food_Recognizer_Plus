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
    private var topNotificationsController: TopNotificationsController?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RecipesViewControllerPresenter(delegate: self)
        
        topNotificationsController = TopNotificationsController(view: self.view, maxNotificationsAmount: 1)
        setupNavigationView()
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private. Setup
    
    private func reloadItems(){
        let items = RecipesViewControllerItemsFactory.items(recipes)
        
        set(items: items, animated: false)
    }
    
    // MARK: - tableViewAdapterDelegate. Overriding
    override func tableViewAdapterNeedsActionsForCellEditing(adapter: TableViewAdapter, cell: TableViewAdapterCell) -> [UITableViewRowAction]? {
        guard let cellData = cell.cellData as? RecipeCellData, state == .recipesFromApi else { return nil }
            let saveAction = UITableViewRowAction(style: .normal, title: _L("LNG_SAVE")) { _, _ in
                self.presenter?.saveClickedRecipeToDB(recipe: cellData.recipe)
            }
        return [saveAction]
    }
    
    override func tableViewAdapterUserDidDeleteCell(adapter: TableViewAdapter, cell: TableViewAdapterCell?) {
        let cellData = cell?.cellData as? RecipeCellData
        presenter?.deleteRecipeFromDB(recipe: cellData?.recipe)
    }
    
    // MARK: - ViewControllerProtocol. Overriding
    override func setupNavigationView() {
        setNavigationViewRightButtonIsHidden(true)
        switch state {
        case .recipesFromApi: setNavigationViewTitle(_L("LNG_RECIPES"))
        case .recipesFromDB: setNavigationViewTitle(_L("LNG_SAVED_RECIPES"))
        }
        
    }
}


extension RecipesViewController: RecipesViewControllerProtocol {
    func showTopNotification(item: TopNotificationsControllerCollectionViewItem) {
        topNotificationsController?.add(item: item)
    }
    
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
