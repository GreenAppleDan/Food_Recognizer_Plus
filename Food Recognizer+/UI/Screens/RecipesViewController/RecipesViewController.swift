//
//  RecipesViewController.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class RecipesViewController: BaseViewController<RecipesViewControllerPresenter> {
    
    // MARK: - Properties
    var screensFactory: ScreensFactory?
    
    var recipes: [Recipe]?
    var state: RecipesViewControllerState = .recipesFromApi
    private var topNotificationsController: TopNotificationsController?
    
    private var latestTableViewYOffset: CGFloat = 0
    
    private var longPressGestureForDraggableButtonVew = UILongPressGestureRecognizer()
    private var latestPositionOfDraggableButtonView : CGPoint?
    // MARK: - IBOutlets
    @IBOutlet private weak var movingBottomView: UIView?
    @IBOutlet private weak var movingBottomViewButton: UIButton?
    @IBOutlet private weak var topOfMovingViewToBottomOfTableView: NSLayoutConstraint?
    @IBOutlet private weak var draggableButtonView: UIView?
    
    // MARK: - IBActions
    @IBAction func movingBottomViewButtonDidTap(_ sender: UIButton) {
        guard let recipes = recipes else { return }
        switch state {
        case .recipesFromApi:
            for recipe in recipes {
                presenter?.saveRecipeToDB(recipe: recipe, showTopNotification: false)
            }
            presenter?.showTopNotification(text: "Recipes saved successfully!")
        case .recipesFromDB:
            for recipe in recipes {
                presenter?.deleteRecipeFromDB(recipe: recipe)
            }
            presenter?.showTopNotification(text: "Recipes deleted successfully!")
            self.recipes = nil
            reloadItems(animated: true)
        }
        
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RecipesViewControllerPresenter(delegate: self)
        
        recipes = presenter?.getUniqueRecipes(recipes: recipes)
        topNotificationsController = TopNotificationsController(view: self.view, maxNotificationsAmount: 1)
        setupDraggableButtonView()
        setupNavigationView()
        setupMovingBottomView()
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let latestPositionOfDraggableButtonView = latestPositionOfDraggableButtonView else { return }
        draggableButtonView?.center = latestPositionOfDraggableButtonView
    }
    
    // MARK: - Private. Setup
    
    private func reloadItems(animated: Bool = false){
        let items = RecipesViewControllerItemsFactory.items(recipes)
        
        set(items: items, animated: false)
    }
    
    // MARK: - tableViewAdapterDelegate. Overriding
    override func tableViewAdapterNeedsActionsForCellEditing(adapter: TableViewAdapter, cell: TableViewAdapterCell) -> [UITableViewRowAction]? {
        guard let cellData = cell.cellData as? RecipeCellData, state == .recipesFromApi else { return nil }
        let saveAction = UITableViewRowAction(style: .normal, title: _L("LNG_SAVE")) { _, _ in
            self.presenter?.saveRecipeToDB(recipe: cellData.recipe, showTopNotification: true)
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
    // MARK: - setting up moving bottom view
    func setupMovingViewButton() {
        switch state {
        case .recipesFromDB:
            movingBottomViewButton?.setTitle("Delete all recipes", for: .normal)
            movingBottomViewButton?.layer.cornerRadius = 10
            movingBottomViewButton?.backgroundColor = Colors.red
        case .recipesFromApi:
            movingBottomViewButton?.setTitle("Save all recipes", for: .normal)
            movingBottomViewButton?.layer.cornerRadius = 10
            movingBottomViewButton?.backgroundColor = Colors.green
        }
        
        movingBottomViewButton?.setTitleColor(Colors.white, for: .normal)
    }
    
    func setupMovingBottomView(){
        movingBottomView?.backgroundColor = Colors.gray
        setupMovingViewButton()
    }
    
    // MARK: - setting up draggable ButtonView
    func setupDraggableButtonView() {
        guard let draggableButtonView = draggableButtonView else { return }
        draggableButtonView.backgroundColor = Colors.black
        draggableButtonView.layer.cornerRadius = draggableButtonView.bounds.height / 2
        
        longPressGestureForDraggableButtonVew = UILongPressGestureRecognizer(target: self, action: #selector(draggableButtonViewLongTap))
//        longPressGestureForDraggableButtonVew.numberOfTouchesRequired = 1
//        longPressGestureForDraggableButtonVew.numberOfTapsRequired = 1
        longPressGestureForDraggableButtonVew.delegate = self
        draggableButtonView.addGestureRecognizer(longPressGestureForDraggableButtonVew)
    }
    
    @objc func draggableButtonViewLongTap(_ sender: UILongPressGestureRecognizer) {
        guard let draggableButtonView = draggableButtonView else { return }
        switch sender.state {
            
        case .began:
            UIView.animate(withDuration: 0.2, animations: {
                draggableButtonView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            }) { (finished) in
                UIView.animate(withDuration: 0.2) {
                    draggableButtonView.transform = CGAffineTransform(scaleX: 2, y: 2)
                }
            }
        case .changed:
            print("hi")
            self.view.bringSubviewToFront(draggableButtonView)
                let location = sender.location(in: self.view)
                draggableButtonView.center = location
            case .ended:
                let center = draggableButtonView.center
         latestPositionOfDraggableButtonView = center
            print("hi")
            if center.y <= 40 || center.y > self.view.bounds.height - 50 || center.x < 20 || center.x > self.view.bounds.width - 20 {
                draggableButtonView.center = CGPoint(x: self.view.bounds.width - 32, y: self.view.bounds.height/2)
            }
            UIView.animate(withDuration: 0.3) {
                let transform = CGAffineTransform(scaleX: 1, y: 1)
                draggableButtonView.transform = transform
            }
            print("hi")
        default: return
        }
        
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        presenter?.saveRecipeToDB(recipe: recipeCell.data?.recipe, showTopNotification: false)
        presenter?.processRecipeLinkAndTitle(link: linkString, title: title)
    }
    
    
}
