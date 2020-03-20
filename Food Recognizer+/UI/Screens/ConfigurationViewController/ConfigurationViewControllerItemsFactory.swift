//
//  ConfigurationViewControllerItemsFactory.swift
//  Food Recognizer+
//
//  Created by dev on 20.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class ConfigurationViewControllerItemsFactory {
    static func items() -> [TableViewAdapterItem] {
        var items = [TableViewAdapterItem]()
        
        let languageItem = CellItemsFactory.customTextItem(cellIdentifier: ConfigurationViewControllerItemIdentifier.chooseLanguage.rawValue, leftLabelText: _L("LNG_INTERFACE_LANGUAGE"), leftLabelColor: Colors.gray, rightLabelText: LocalizationManager.currentLanguageName().capitalized, rightLabelColor: Colors.black, alternativeImage: UIImage(named: LocalizationManager.currentLanguageCode().uppercased()), isArrowHidden: false)
        
        items.append(languageItem)
        
        return items
    }
}
