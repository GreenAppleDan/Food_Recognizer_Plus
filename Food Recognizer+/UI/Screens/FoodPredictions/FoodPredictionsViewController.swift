//
//  FoodPredictionsViewController.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class FoodPredictionsViewController: ViewController<FoodPredictionsViewControllerPresenter> {
    // MARK: - Outlets
    
    // MARK: - Properties
    var clarifaiPredictions: [ClarifaiFoodPrediction]?
    var recipePuppyService: RecipePuppyService?
    var screensFactory: ScreensFactory?
    
    private var chosenIngridientNames = Set<String>()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let recipePuppyService = recipePuppyService else { return }
        presenter = FoodPredictionsViewControllerPresenter(delegate: self, recipePuppyService: recipePuppyService)
        
        
        setupNavigationView()
        
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private
    
    private func reloadItems(){
        let items = FoodPredictionsViewControllerPresenterItemsFactory.items(predictions: clarifaiPredictions ?? [])
        
        set(items: items, animated: false)
    }
    
    // MARK: - ViewControllerProtocol. Overriding
    override func setupNavigationView() {
        navigationView?.backButtonIsHidden = false
        navigationView?.set(title: "Predictions")
        navigationView?.setRightButton(title: "Get recipes", image: nil)
    }
   // MARK: - NavigationViewDelegate
    
    override func navigationViewDidTapRightButton(_ view: NavigationView) {
        if chosenIngridientNames.isEmpty {
            showAlert(title: "You have not chosen any ingridients")
        } else {
            presenter?.getRecipesWithIngridientNames(ingridientNames: Array(chosenIngridientNames))
        }
    }
}


extension FoodPredictionsViewController: IngridientProbabilityPredictionCellActionHandlerDelegate {
    func ingridientProbabilityCellOverlayingbuttonDidTap(_ cell: IngridientProbabilityPredictionCell, cellIdentifier: String) {
        guard let cellData = cell.data else { return }
        if cell.isChosen == true {
            cell.toggleSelection()
            chosenIngridientNames.remove(cellData.ingridientName)
        } else {
            cell.toggleSelection()
            chosenIngridientNames.insert(cellData.ingridientName)
        }
    }
}

extension FoodPredictionsViewController: FoodPredictionsViewControllerProtocol {
    func moveToRecipesViewController(_ recipes: [Recipe]?) {
        guard let recipesViewController = screensFactory?.recipesViewController(recipes: recipes, state: .recipesFromApi) else { return }
        pushViewController(recipesViewController)
    }
    
    
}

