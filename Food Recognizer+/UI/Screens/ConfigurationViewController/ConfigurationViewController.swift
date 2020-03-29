//
//  ConfigurationViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewController: BaseViewController<ConfigurationViewControllerPresenter>{
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ConfigurationViewControllerPresenter(delegate: self)
        
        setupNavigationView()
        reloadItems()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Overriding
    override func setupNavigationView() {
        navigationView?.backButtonIsHidden = true
        navigationView?.set(title: _L("LNG_CONFIGURATION"))
    }
    
    // MARK: - Private
    
    private func reloadItems(){
        let items = ConfigurationViewControllerItemsFactory.items()
        
        set(items: items, animated: false)
    }
}


extension ConfigurationViewController: ConfigurationViewControllerProtocol {
    
}

extension ConfigurationViewController: TableViewAdapterCellActionHandlerDelegate {
    func tableViewAdapterCellDidTap(_ tableViewAdapterCell: TableViewAdapterCell, withIdentifier identifier: String) {
        guard let identifier = ConfigurationViewControllerItemIdentifier(rawValue: identifier) else { return }
        
        switch identifier {
        case .chooseLanguage:
            
            let alertController = UIAlertController.init(title: _L("LNG_LANGUAGE"), message: "", preferredStyle: .actionSheet)
            alertController.view.tintColor = self.view.tintColor

            let size = CGSize(width: 36, height: 24)
            let locales = presenter?.getAvailableLocales() ?? []

            for locale in locales {
                let name = presenter?.getLanguageName(with: locale) ?? ""
                let alertAction = UIAlertAction.init(title: name, style: .default, handler: { _ in
                    self.presenter?.setCurrentLocale(code: locale)
                })

                let img = UIImage(named: locale)?.scaledToSize(size: size).withRenderingMode(.alwaysOriginal) ?? UIImage()
                alertAction.setValue(img, forKey: "image")

                alertController.addAction(alertAction)
            }

            let cancel = UIAlertAction.init(title: _L("LNG_CANCEL"), style: .cancel)
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true, completion: nil)
    }
    
    }
}
