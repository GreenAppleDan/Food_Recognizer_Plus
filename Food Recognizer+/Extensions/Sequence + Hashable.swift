//
//  Sequence + Hashable.swift
//  Food Recognizer+
//
//  Created by dev on 29.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
