//
//  TableViewAdapterPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class TableViewAdapterPresenter: NSObject, TableViewAdapterDelegate {
    // MARK: - Properties
    
    private var isShouldScrollTableViewOnKeyboardAppearanceFlag: Bool = true
    weak var viewController: UIViewController?
    weak var tableViewAdapter: TableViewAdapter?
    
    private(set) var visibleCells: [String: TableViewAdapterCell] = [:]
    
    init(tableViewAdapter: TableViewAdapter? = nil, viewController: UIViewController?) {
        super.init()
        
        self.tableViewAdapter = tableViewAdapter
        self.viewController = viewController
    }
    
    // MARK: - Actions
    
    open func handle(action: TableViewAdapterCellAction) {
        let cell = visibleCells[action.cellIdentifier]
        cell?.handler?.handle(action, cell: cell)
    }
    
    open func handleAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {
        
    }
    
    open func handleAdapterTableViewWillScroll(adapter: TableViewAdapter,
                                               contentPosition: TableViewAdapterScrollPosition,
                                               direction: TableViewAdapterScrollDirection) {
        
    }
    
    open func handleAdapterTableView(adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat) {
        
    }
    
    open func isShouldSwipeOut() -> Bool {
        return true
    }
    
    open func isShouldScrollTableViewOnKeyboardAppearance() -> Bool {
        return self.isShouldScrollTableViewOnKeyboardAppearanceFlag
    }
    
    // MARK: - Life cycle
    
    open func viewDidLoad() {
        tableViewAdapter?.tableView?.keyboardDismissMode = .onDrag
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    open func viewWillAppear(isNavigationBarHidden: Bool, hidesShadow: Bool = true) {
        
        isShouldScrollTableViewOnKeyboardAppearanceFlag = true
    }
    
    public func viewWillDisappear() {
        isShouldScrollTableViewOnKeyboardAppearanceFlag = false
    }
    
    // MARK: - Interface
    
    public func set(title: String, font: UIFont? = nil) {
        viewController?.title = title
        if let font = font {
            viewController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
    
    open func set(items: [TableViewAdapterItem], animated: Bool = false) {
        tableViewAdapter?.clear()
        items.forEach {
            tableViewAdapter?.unsafeAdd(item: $0)
            $0.cellHandler?.delegate = self
        }
        reloadData(animated: animated)
    }
    
    open func reloadData(animated: Bool = false) {
        tableViewAdapter?.reloadData(animated: animated)
    }
    
    // MARK: - Safe Area
    
    public var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets()
    }
    
    // MARK: - Keyboard
    
    @objc private func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardTopY = UIScreen.main.bounds.height - endFrame.origin.y
        if keyboardTopY > 0 {
            handleKeyboardAppearance(keyboardTopY: keyboardTopY)
        }
        else {
            handleKeyboardDisappearance(keyboardTopY: keyboardTopY)
        }
    }
    
    open func handleKeyboardDisappearance(keyboardTopY: CGFloat) {
        
    }
    
    open func handleKeyboardAppearance(keyboardTopY: CGFloat) {
        
        if isShouldScrollTableViewOnKeyboardAppearance() {
            guard var tableViewContentOffset = tableViewAdapter?.tableView?.contentOffset else { return }
            tableViewContentOffset.y += tableViewContentOffset.y + keyboardTopY
            tableViewAdapter?.tableView?.setContentOffset(tableViewContentOffset, animated: true)
        }
        
    }
    
    // MARK: - TableViewAdapterDelegate
    
    open func tableViewAdapterTableViewWillScroll(
        adapter: TableViewAdapter,
        contentPosition: TableViewAdapterScrollPosition,
        direction: TableViewAdapterScrollDirection
    ) {
        handleAdapterTableViewWillScroll(adapter: adapter, contentPosition: contentPosition, direction: direction)
    }
    
    public func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {
        handleAdapterTableViewDidScroll(adapter: adapter, contentOffset: contentOffset)
    }
    
    open func tableViewAdapterCellWillDissappear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {
        if let cellIdentifier = cell.cellData?.cellIdentifier {
            visibleCells.removeValue(forKey: cellIdentifier)
        }
    }
    
    open func tableViewAdapterCellWillAppear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {
        if let cellIdentifier = cell.cellData?.cellIdentifier {
            visibleCells[cellIdentifier] = cell
        }
    }
    
    public func tableViewAdapter(_ adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat) {
        handleAdapterTableView(adapter: adapter, didReachBorderPosition: borderPosition, offset: offset)
    }
}

extension TableViewAdapterPresenter: TableCellActionHandlerDelegate {
    
}
