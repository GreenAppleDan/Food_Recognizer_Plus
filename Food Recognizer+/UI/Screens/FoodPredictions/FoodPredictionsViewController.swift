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
    
    private var chosenIngridientNames = Set<String>()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let recipePuppyService = recipePuppyService else { return }
        presenter = FoodPredictionsViewControllerPresenter(delegate: self, recipePuppyService: recipePuppyService)
        
        
        tableViewAdapter?.tableView?.separatorStyle = .none
        setupNavigationView()
        
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private
    private func setupNavigationView() {
        navigationView?.backButtonIsHidden = false
        navigationView?.set(title: "Predictions")
        navigationView?.setRightButton(title: "Get recipes", image: nil)
    }
    
    private func reloadItems(){
        let items = FoodPredictionsViewControllerPresenterItemsFactory.items(predictions: clarifaiPredictions ?? [])
        
        set(items: items, animated: false)
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

extension FoodPredictionsViewController: FoodPredictionsViewControllerProtocol{
    
}

