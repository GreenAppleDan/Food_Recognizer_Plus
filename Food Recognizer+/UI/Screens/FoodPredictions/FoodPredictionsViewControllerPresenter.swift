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
