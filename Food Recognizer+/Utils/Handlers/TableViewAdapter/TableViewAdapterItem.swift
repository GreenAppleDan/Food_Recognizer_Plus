//
//  TableViewAdapterItem.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//
import UIKit

public class TableViewAdapterItem {
    
    public let cellClass: AnyClass
    public let cellData: TableViewAdapterItemData?
    public let cellBundleIdentifier: String?
    public var cellHandler: TableViewAdapterCellActionHandler?
    
    public var cellReuseIdentifier: String {
        return String(describing: cellClass)
    }
    
    // MARK: - Initialization
    
    public init(cellClass: AnyClass,
                cellData: TableViewAdapterItemData? = nil,
                cellBundleIdentifier: String? = nil,
                cellHandler: TableViewAdapterCellActionHandler? = nil) {
        self.cellClass = cellClass
        self.cellData = cellData
        self.cellBundleIdentifier = cellBundleIdentifier
        self.cellHandler = cellHandler
    }
    
    // MARK: - Interface
    
    public func height() -> CGFloat {
        return cellData?.cellHeight() ?? UITableView.automaticDimension
    }
    
    func canEdit() -> Bool {
        return cellData?.canEdit() ?? false
    }
}

extension TableViewAdapterItem: Equatable {
    public static func == (lhs: TableViewAdapterItem, rhs: TableViewAdapterItem) -> Bool {
        return lhs.cellData?.cellIdentifier == rhs.cellData?.cellIdentifier
    }
}

