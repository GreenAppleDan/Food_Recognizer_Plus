//
//  PhotoAnalyserViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
class PhotoAnalyserViewController: ViewController<PhotoAnalyserViewControllerPresenter> {
    @IBOutlet weak var navigationView: NavigationView?
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView?
    
    
    var clarifaiService: ClarifaiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clarifaiService = clarifaiService else { return }
        presenter = PhotoAnalyserViewControllerPresenter(tableViewAdapter: tableViewAdapter, viewController: self, navigationView: navigationView, activityIndicatorView: activityIndicatorView, clarifaiService: clarifaiService)
        
        presenter?.viewDidLoad()
    }
}
