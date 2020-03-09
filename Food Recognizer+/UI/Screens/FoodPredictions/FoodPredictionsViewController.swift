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
    @IBOutlet private weak var navigationView: NavigationView?
    
    // MARK: - Properties
    var clarifaiPredictions: [ClarifaiFoodPrediction]?
    var recipePuppyService: RecipePuppyService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let clarifaiPredictions = clarifaiPredictions else { return }
        guard let recipePuppyService = recipePuppyService else { return }
        presenter = FoodPredictionsViewControllerPresenter(tableViewAdapter: tableViewAdapter, viewController: self, navigationView: navigationView, clarifaiPredictions: clarifaiPredictions, recipePuppyService: recipePuppyService)
        
        presenter?.viewDidLoad()
    }
}
