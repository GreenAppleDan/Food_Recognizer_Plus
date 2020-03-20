//
//  ConfigurationViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewControllerPresenter: TableViewAdapterPresenter<ConfigurationViewControllerProtocol> {
    
    func getAvailableLocales() -> [String] {
        return LocalizationManager.availableLocales
    }
    
    func getLanguageName(with code: String) -> String {
        return LocalizationManager.languageName(withCode: code).capitalized
    }
    
    func setCurrentLocale(code: String) {
        LocalizationManager.setCurrentLocale(code: code)
    }
}
