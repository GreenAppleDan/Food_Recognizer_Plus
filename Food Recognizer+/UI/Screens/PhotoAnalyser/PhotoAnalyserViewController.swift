//
//  PhotoAnalyserViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
class PhotoAnalyserViewController: ViewController<PhotoAnalyserViewControllerPresenter> {
    @IBOutlet weak var navigationView: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PhotoAnalyserViewControllerPresenter(tableViewAdapter: tableViewAdapter, viewController: self, navigationView: navigationView)
        
        presenter?.viewDidLoad()
    }
}
