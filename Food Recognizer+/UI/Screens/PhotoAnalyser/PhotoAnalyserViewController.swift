//
//  PhotoAnalyserViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
class PhotoAnalyserViewController: ViewController<PhotoAnalyserViewControllerPresenter> {
    // MARK: - Outlets
    @IBOutlet weak var navigationView: NavigationView?
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView?
    
    // MARK: - Properties
    var clarifaiService: ClarifaiService?
    var screensFactory: ScreensFactory?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clarifaiService = clarifaiService else { return }
        guard let screensFactory = screensFactory else { return }
        presenter = PhotoAnalyserViewControllerPresenter(tableViewAdapter: tableViewAdapter, viewController: self, screensFactory: screensFactory, navigationView: navigationView, activityIndicatorView: activityIndicatorView, clarifaiService: clarifaiService)
        
        presenter?.viewDidLoad()
    }
}
