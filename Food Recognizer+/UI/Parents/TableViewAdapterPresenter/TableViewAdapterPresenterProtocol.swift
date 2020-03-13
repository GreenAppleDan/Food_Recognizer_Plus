//
//  TableViewAdapterPresenterProtocol.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public protocol TableViewAdapterPresenterProtocol {
    func detach()

    func handleAction(_ action: TableViewAdapterCellAction)
    func isShouldSwipeOut() -> Bool

    // MARK: - Life cycle

    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func reloadData()

    // MARK: - TableViewAdapterDelegate

    func tableViewAdapterTableViewWillScroll(
        adapter: TableViewAdapter,
        contentPosition: TableViewAdapterScrollPosition,
        direction: TableViewAdapterScrollDirection
    )
    func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint)
    func tableViewAdapter(_ adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat)
}
