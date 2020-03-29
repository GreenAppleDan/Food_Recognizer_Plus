//
//  MainNavigationViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationViewController: BaseViewController<MainNavigationViewControllerPresenter> {
    
    // MARK: - Properties
    private weak var pageViewController: UITabBarController?
    var screensFactory: ScreensFactory?
    
    private var identifierToViewController: [MainNavigationViewControllerPresenterBarItemIdentifier : UIViewController] = [:]
    private var viewControllerToIdentifier: [UIViewController : MainNavigationViewControllerPresenterBarItemIdentifier] = [:]
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mainNavigationTabBarView: MainNavigationTabBarView?
    @IBOutlet private weak var shadowView: UIView?
    
    
    // MARK: - ViewControllers
    private weak var photoAnalyserViewController: PhotoAnalyserViewController?
    private weak var configurationViewController: ConfigurationViewController?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainNavigationViewControllerPresenter(delegate: self)
        
        pageViewController?.tabBar.isHidden = true
        
        setupShadowView()
        prepareTabBarView()
        
        prepareViewControllers()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let firstItem = mainNavigationTabBarView?.dataArray.entityAt(0) else { return }
        var selectedIdentifier = mainNavigationTabBarView?.selected()
        
        if selectedIdentifier == nil {
            selectedIdentifier = firstItem.identifier
        }
        
        guard let selected = selectedIdentifier else { return }
        DispatchQueue.main.async { [weak self] in
            self?.mainNavigationTabBarView?.set(selected: true,
            identifier: selected, animated: false)
        }
    }
    
    
    // MARK: - Preparing for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embed" {
            self.pageViewController = segue.destination as? UITabBarController
        }
    }
    
    
    // MARK: - Private
    private func setupShadowView() {
        shadowView?.addShadow(shadowOffset: CGSize(width: 0, height: 0))
    }
    
    private func link(identifier: MainNavigationViewControllerPresenterBarItemIdentifier, with viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        
        identifierToViewController[identifier] = viewController
        viewControllerToIdentifier[viewController] = identifier
    }
}


extension MainNavigationViewController: MainNavigationTabBarViewDelegate {
    func mainNavigationTabBarView(_ view: MainNavigationTabBarView, itemDidTapWithIdentifier identifier: String) {
        guard let itemIdentifier = MainNavigationViewControllerPresenterBarItemIdentifier(rawValue: identifier) else { return }
        guard let viewController = identifierToViewController[itemIdentifier] else { return }
        guard let index = pageViewController?.viewControllers?.firstIndex(of: viewController) else { return }
        
        mainNavigationTabBarView?.set(selected: true, identifier: identifier, animated: true)
        pageViewController?.selectedIndex = index
    }
}

extension MainNavigationViewController: MainNavigationViewControllerProtocol {
    
    func setTabBarViewIdentifier(identifier: String) {
        mainNavigationTabBarView?.set(selected: true, identifier: identifier, animated: false)
    }
    
    func getCurrentlySelectedTabBarIdentifier() -> String? {
        return mainNavigationTabBarView?.selected()
    }
    
    func prepareTabBarView() {
        mainNavigationTabBarView?.clear()
        
        let photoAnalyserTabBarButtonData = MainNavigationTabBarButtonViewData(identifier: MainNavigationViewControllerPresenterBarItemIdentifier.photoAnalyser.rawValue, image: UIImage(named: "Face"), labelText: _L("LNG_ANALYSER"))
        mainNavigationTabBarView?.add(data: photoAnalyserTabBarButtonData)
        
        let configurationViewTabBarButtonData = MainNavigationTabBarButtonViewData(identifier: MainNavigationViewControllerPresenterBarItemIdentifier.configuration.rawValue, image: UIImage(named: "Configuration"), labelText: _L("LNG_CONFIGURATION"))
        
        mainNavigationTabBarView?.delegate = self
        mainNavigationTabBarView?.add(data: configurationViewTabBarButtonData)
        
        mainNavigationTabBarView?.arrangeStackViewSubviews()
    }
    
    func prepareViewControllers() {
        var viewControllers: [UIViewController] = []
        
        photoAnalyserViewController = screensFactory?.photoAnalyserViewController(delegate: self)
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
}

extension MainNavigationViewController: TabBarHandler {
    func toggleTabBarInteractable(_ isInteractable: Bool) {
        mainNavigationTabBarView?.isUserInteractionEnabled = isInteractable
    }
}
