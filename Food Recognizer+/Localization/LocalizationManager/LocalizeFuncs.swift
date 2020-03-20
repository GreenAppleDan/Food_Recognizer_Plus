//
//  LocalizeFuncs.swift
//  Food Recognizer+
//
//  Created by dev on 20.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

public func _L(_ key: String) -> String {
    return LocalizationManager.localizedString(key)
}

public func _LF(_ key: String, _ values: String...) -> String {
    return LocalizationManager.format(key: key, values: values)
}

public func _LC(_ key: String, _ count: Int) -> String {
    return _LC(key, Float(count))
}

public func _LC(_ key: String, _ count: Float) -> String {
    return LocalizationManager.localizedString(forCount: count, key: key)
}
