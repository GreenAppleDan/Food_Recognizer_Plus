//
//  TableViewAdapterPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

open class TableViewAdapterPresenter<T>: TableViewAdapterPresenterProtocol {
    
    // MARK: - Properties

    public var delegate: T?
    
    // MARK: - Life-cycle
    
    public init(delegate: T) {
        
        attach(delegate: delegate)
    }
    
    deinit {
        detach()
    }
    
    // MARK: - Actions

    open func attach(delegate: T) {
        self.delegate = delegate
    }

    open func detach() {
        self.delegate = nil
    }
    
    open func handleAction(_ action: TableViewAdapterCellAction) {

    }
    
    open func isShouldSwipeOut() -> Bool {
        return true
    }

    // MARK: - Life cycle
    
    open func viewDidLoad() {

    }
    
    open func viewWillAppear() {
    }
    
    open func viewWillDisappear() {

    }

    open func reloadData() {

    }

    // MARK: - TableViewAdapterDelegate
    
    open func tableViewAdapterTableViewWillScroll(
        adapter: TableViewAdapter,
        contentPosition: TableViewAdapterScrollPosition,
        direction: TableViewAdapterScrollDirection
        ) {

    }
    
    public func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {

    }
    
    public func tableViewAdapter(_ adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat) {

    }

}
