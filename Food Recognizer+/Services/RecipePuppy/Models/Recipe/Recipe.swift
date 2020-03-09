//
//  Recipe.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

class Recipe: HandyJSON {
    var title: String?
    var href: String?
    var ingredients: String?
    var thumbnail: String?
    
    required init() {}
}
