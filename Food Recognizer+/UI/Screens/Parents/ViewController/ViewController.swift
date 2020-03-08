//
//  ViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ViewController<T: TableViewAdapterPresenter>: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet public weak var tableView: UITableView?
    
    
    // MARK: - Properties
    
    public var tableViewAdapter: TableViewAdapter?
    public var presenter: T?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tableViewAdapter = TableViewAdapter(tableView: tableView, delegate: self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear(isNavigationBarHidden: true)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
}

extension ViewController: TableViewAdapterDelegate {
    public func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {
        presenter?.handleAdapterTableViewDidScroll(adapter: adapter,
                                                   contentOffset: contentOffset)
    }

    public func tableViewAdapterTableViewWillScroll(adapter: TableViewAdapter, contentPosition: TableViewAdapterScrollPosition, direction: TableViewAdapterScrollDirection) {
        presenter?.tableViewAdapterTableViewWillScroll(adapter: adapter,
                                                       contentPosition: contentPosition,
                                                       direction: direction)
    }
    
    public func tableViewAdapterCellWillAppear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {
        presenter?.tableViewAdapterCellWillAppear(adapter: adapter, cell: cell)
    }

    public func tableViewAdapterCellWillDissappear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {
        presenter?.tableViewAdapterCellWillDissappear(adapter: adapter, cell: cell)
    }

    public func handle(action: TableViewAdapterCellAction) {
        presenter?.handle(action: action)
    }

    public func tableViewAdapter(_ adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat) {
        presenter?.tableViewAdapter(adapter, didReachBorderPosition: borderPosition, offset: offset)
    }

}
