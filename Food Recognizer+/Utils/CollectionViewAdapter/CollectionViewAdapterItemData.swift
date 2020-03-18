//
//  CollectionViewAdapterItemData.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

open class CollectionViewAdapterItemData {
    
    let cellIdentifier: String
    
    public init(cellIdentifier: String = UUID().uuidString) {
        self.cellIdentifier = cellIdentifier
    }
    
}
