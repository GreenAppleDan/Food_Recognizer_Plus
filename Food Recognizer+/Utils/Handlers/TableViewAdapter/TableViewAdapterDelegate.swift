//
//  TableViewAdapterDelegate.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
public protocol TableViewAdapterDelegate: class {
    func tableViewAdapterCellWillAppear(adapter: TableViewAdapter, cell: TableViewAdapterCell)
    func tableViewAdapterCellWillDissappear(adapter: TableViewAdapter, cell: TableViewAdapterCell)
    func tableViewAdapterTableViewWillScroll(adapter: TableViewAdapter, contentPosition: TableViewAdapterScrollPosition, direction: TableViewAdapterScrollDirection)
    func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint)
    func tableViewAdapter(_ adapter: TableViewAdapter,
                          didReachBorderPosition borderPosition: TableViewAdapterBorderPosition,
                          offset: CGFloat)
}
