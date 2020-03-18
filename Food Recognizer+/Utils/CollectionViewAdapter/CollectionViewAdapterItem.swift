//
//  CollectionViewAdapterItem.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public class CollectionViewAdapterItem {
    
    private let cellClass: AnyClass
    public let cellData: CollectionViewAdapterItemData?
    public let cellBundleIdentifier: String?
    
    public var cellIdentifier: String {
        return String(describing: cellClass)
    }
    
    // MARK: - Initialization
    
    public init(cellClass: AnyClass,
                cellData: CollectionViewAdapterItemData? = nil,
                cellBundleIdentifier: String? = nil) {
        self.cellClass = cellClass
        self.cellData = cellData
        self.cellBundleIdentifier = cellBundleIdentifier
    }
    
}

extension CollectionViewAdapterItem: Equatable {
    
    public static func == (lhs: CollectionViewAdapterItem, rhs: CollectionViewAdapterItem) -> Bool {
        if let left = lhs.cellData?.cellIdentifier, let right = rhs.cellData?.cellIdentifier {
            return left == right
        }
        return false
    }
    
}
