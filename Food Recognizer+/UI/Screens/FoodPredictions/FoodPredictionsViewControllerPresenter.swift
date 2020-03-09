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
    var clarifaiPredictions: [ClarifaiFoodPrediction]
    
    
    var chosenIngridientNames = Set<String>()
    
    init(tableViewAdapter: TableViewAdapter?, viewController: UIViewController?, navigationView: NavigationView?, clarifaiPredictions: [ClarifaiFoodPrediction]) {
        self.navigationView = navigationView
        self.clarifaiPredictions = clarifaiPredictions
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
