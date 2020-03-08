//
//  MainNavigationViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationViewControllerPresenter: TableViewAdapterPresenter {
    
    // MARK: - Properties
    private weak var pageViewController: UITabBarController?
    private weak var mainNavigationTabBarView: MainNavigationTabBarView?
    
    private var screensFactory: ScreensFactory?
    
    private var identifierToViewController: [MainNavigationViewControllerPresenterBarItemIdentifier : UIViewController] = [:]
    private var viewControllerToIdentifier: [UIViewController : MainNavigationViewControllerPresenterBarItemIdentifier] = [:]
    
    // MARK: - ViewControllers
    private weak var photoAnalyserViewController: PhotoAnalyserViewController?
    private weak var configurationViewController: ConfigurationViewController?
    // MARK: - Life Cycle
    init(viewController: UIViewController, pageViewController: UITabBarController?, screensFactory: ScreensFactory?, mainNavigationTabBarView: MainNavigationTabBarView?) {
        self.pageViewController = pageViewController
        self.screensFactory = screensFactory
        self.mainNavigationTabBarView = mainNavigationTabBarView
        super.init(viewController: viewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController?.tabBar.isHidden = true
        
        prepareTabBarView()
        
        prepareViewControllers()
    }
    
    func viewDidLayoutSubviews() {
        guard let firstItem = mainNavigationTabBarView?.dataArray.entityAt(0) else { return }
        var selectedIdentifier = mainNavigationTabBarView?.selected()
        
        if selectedIdentifier == nil {
            selectedIdentifier = firstItem.identifier
        }
        
        guard let selected = selectedIdentifier else { return }
        
        
        //DispatchQueue.main.asyncAfter(deadline: .now()) {
        mainNavigationTabBarView?.set(selected: true,
                                      identifier: selected, animated: false)
        //}
    }
    // MARK: - Private
    
    private func prepareTabBarView() {
        mainNavigationTabBarView?.clear()
        
        let photoAnalyserTabBarButtonData = MainNavigationTabBarButtonViewData(identifier: MainNavigationViewControllerPresenterBarItemIdentifier.photoAnalyser.rawValue, image: UIImage(named: "Face"), labelText: "Analyser")
        mainNavigationTabBarView?.add(data: photoAnalyserTabBarButtonData)
        
        let configurationViewTabBarButtonData = MainNavigationTabBarButtonViewData(identifier: MainNavigationViewControllerPresenterBarItemIdentifier.configuration.rawValue, image: UIImage(named: "Configuration"), labelText: "Configuration")
        
        mainNavigationTabBarView?.delegate = self
        mainNavigationTabBarView?.add(data: configurationViewTabBarButtonData)
        
        mainNavigationTabBarView?.arrangeStackViewSubviews()
    }
    
    private func prepareViewControllers() {
        var viewControllers: [UIViewController] = []
        
        photoAnalyserViewController = screensFactory?.photoAnalyserViewController()
        guard let photoAnalyserViewController = photoAnalyserViewController else { return }
        viewControllers.append(photoAnalyserViewController)
        
        configurationViewController = screensFactory?.configurationViewController()
        guard let configurationViewController = configurationViewController else { return }
        viewControllers.append(configurationViewController)
        
        pageViewController?.viewControllers = viewControllers
        
        identifierToViewController.removeAll()
        viewControllerToIdentifier.removeAll()
        
        link(identifier: .photoAnalyser, with: photoAnalyserViewController)
        link(identifier: .configuration, with: configurationViewController)
    }
    
    private func link(identifier: MainNavigationViewControllerPresenterBarItemIdentifier, with viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        
        identifierToViewController[identifier] = viewController
        viewControllerToIdentifier[viewController] = identifier
    }
}

extension MainNavigationViewControllerPresenter: MainNavigationTabBarViewDelegate {
    func mainNavigationTabBarView(_ view: MainNavigationTabBarView, itemDidTapWithIdentifier identifier: String) {
        guard let itemIdentifier = MainNavigationViewControllerPresenterBarItemIdentifier(rawValue: identifier) else { return }
        guard let viewController = identifierToViewController[itemIdentifier] else { return }
        guard let index = pageViewController?.viewControllers?.firstIndex(of: viewController) else { return }
        
        mainNavigationTabBarView?.set(selected: true, identifier: identifier, animated: true)
        pageViewController?.selectedIndex = index
    }
    
    
}
