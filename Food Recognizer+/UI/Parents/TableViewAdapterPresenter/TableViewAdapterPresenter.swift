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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(localizationChanged),
                                               name: Notification.Name.notificationLanguageChanged,
                                               object: nil)
    }
    
    deinit {
        detach()
        
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: - T as ViewControllerProtocol
    
    private func delegateNormalized() -> ViewControllerProtocol? {
        return delegate as? ViewControllerProtocol
    }
    // MARK: - Localization Manager
    
    @objc public func localizationChanged() {
        delegateNormalized()?.reloadData(animated: false)
        delegateNormalized()?.setupNavigationView()
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
