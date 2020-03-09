//
//  FoodPredictionsViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class FoodPredictionsViewControllerPresenter: TableViewAdapterPresenter {
    
    private weak var navigationView: NavigationView?
    private var clarifaiPredictions: [ClarifaiFoodPrediction]
    private var recipePuppyService: RecipePuppyService
    
    private var chosenIngridientNames = Set<String>()
    
    init(tableViewAdapter: TableViewAdapter?, viewController: UIViewController?, navigationView: NavigationView?, clarifaiPredictions: [ClarifaiFoodPrediction], recipePuppyService: RecipePuppyService) {
        self.navigationView = navigationView
        self.clarifaiPredictions = clarifaiPredictions
        self.recipePuppyService = recipePuppyService
        super.init(tableViewAdapter: tableViewAdapter, viewController: viewController)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewAdapter?.tableView?.separatorStyle = .none
        setupNavigationView()
        
        reloadItems()
    }
    
    // MARK: - Private
    private func setupNavigationView() {
        navigationView?.delegate = self
        navigationView?.backButtonIsHidden = false
        navigationView?.set(title: "Predictions")
        navigationView?.setRightButton(title: "Get recipes", image: nil)
    }
    
    private func reloadItems(){
        let items = FoodPredictionsViewControllerPresenterItemsFactory.items(predictions: clarifaiPredictions)
        
        set(items: items, animated: false)
    }
}

extension FoodPredictionsViewControllerPresenter: NavigationViewDelegate {
    func navigationViewDidTapBackButton(_ view: NavigationView) {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigationViewDidTapRightButton(_ view: NavigationView) {
        if chosenIngridientNames.isEmpty {
            viewController?.showAlert(title: "You have not chosen any ingridients")
        } else {
            recipePuppyService.getRecipesWithIngridientNames(names: Array(chosenIngridientNames)) { (response) in
                if let error = response.2 {
                    self.viewController?.show(error)
                } else if let recipes = response.1 {
                    //Переходим на другую вьюшку
                    print(recipes)
                }
            }
        }
    }
}

extension FoodPredictionsViewControllerPresenter: IngridientProbabilityPredictionCellActionHandlerDelegate {
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
