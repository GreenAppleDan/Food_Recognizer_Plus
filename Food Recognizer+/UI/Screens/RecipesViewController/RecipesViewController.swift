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
    
    private var latestTableViewYOffset: CGFloat = 0
    // MARK: - IBOutlets
    @IBOutlet private weak var movingBottomView: UIView?
    @IBOutlet private weak var topOfMovingViewToBottomOfTableView: NSLayoutConstraint?
    
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
                self.presenter?.saveClickedRecipeToDB(recipe: cellData.recipe, showTopNotification: true)
            }
        return [saveAction]
    }
    
    override func tableViewAdapterUserDidDeleteCell(adapter: TableViewAdapter, cell: TableViewAdapterCell?) {
        let cellData = cell?.cellData as? RecipeCellData
        presenter?.deleteRecipeFromDB(recipe: cellData?.recipe)
    }
    
    override func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {
        super.tableViewAdapterTableViewDidScroll(adapter: adapter, contentOffset: contentOffset)
        
        guard let topOfMovingViewToBottomOfTableView = topOfMovingViewToBottomOfTableView else { return }
        let viewYOffset = topOfMovingViewToBottomOfTableView.constant
        let tableViewYOffset = contentOffset.y
        guard let tableViewHeight = tableView?.contentSize.height, tableViewHeight - UIScreen.main.bounds.height + 40 - tableViewYOffset > 70 else { return }
        guard tableViewYOffset > 0 else { return }
        let difference = tableViewYOffset - latestTableViewYOffset
        latestTableViewYOffset = tableViewYOffset
        let constant = topOfMovingViewToBottomOfTableView.constant
        if constant + difference < -40 {
            topOfMovingViewToBottomOfTableView.constant = -40
            tableView?.contentInset.bottom = 40
        } else if constant + difference > 0 {
            topOfMovingViewToBottomOfTableView.constant = 0
            tableView?.contentInset.bottom = 0
        } else {
            topOfMovingViewToBottomOfTableView.constant += difference
            tableView?.contentInset.bottom = abs(topOfMovingViewToBottomOfTableView.constant)
        }
        
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
        presenter?.saveClickedRecipeToDB(recipe: recipeCell.data?.recipe, showTopNotification: false)
        presenter?.processRecipeLinkAndTitle(link: linkString, title: title)
    }
    
    
}
