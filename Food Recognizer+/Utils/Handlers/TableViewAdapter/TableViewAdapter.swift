//
//  TableViewAdapter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 17.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

public class TableViewAdapter: NSObject {
    
    // MARK: - Delegate
    
    public weak var delegate: TableViewAdapterDelegate?
    
    // MARK: - Properties
    
    public private(set) weak var tableView: UITableView?
    
    private var items: [TableViewAdapterItem] = []
    private var updater: TableViewAdapterUpdater?
    
    private var completionAfterScrollViewAnimation: (() -> Void)?
    
    // MARK: - Initialization
    
    public init(tableView: UITableView?, delegate: TableViewAdapterDelegate? = nil) {
        super.init()
        self.delegate = delegate
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        updater = TableViewAdapterUpdater(tableViewAdapter: self)
    }
    
    // MARK: - Unsafe

    public func unsafeAdd(item: TableViewAdapterItem) {
        items.append(item)
        registerNibIfNeeded(for: item)
    }

    public func unsafeReplaceFirst(item: TableViewAdapterItem, byItem replaceByItem: TableViewAdapterItem) throws {
        guard let firstIndex = firstIndex(forItem: item) else {
            throw TableViewAdapterError.runtimeError("TableViewAdapter exception on replace - no such item in items to replace: \(item.cellData?.cellIdentifier ?? "-")")
        }
        
        registerNibIfNeeded(for: replaceByItem)
        items[firstIndex] = replaceByItem
    }
    
    public func unsafeRemoveFirst(item: TableViewAdapterItem) throws {
        guard let firstIndex = firstIndex(forItem: item) else {
            throw TableViewAdapterError.runtimeError("TableViewAdapter exception on remove - no such item in items")
        }
        
        items.remove(at: firstIndex)
    }
    
    public func unsafeInsert(items: [TableViewAdapterItem],
                             afterItem anchorItem: TableViewAdapterItem,
                             insertAfterAnchorItem: Bool = true) throws {
        guard let firstIndex = firstIndex(forItem: anchorItem) else {
            throw TableViewAdapterError.runtimeError("TableViewAdapter exception on insert - no such item in items")
        }

        let insertIndex = insertAfterAnchorItem == true ? firstIndex + 1 : firstIndex
        
        items.forEach { registerNibIfNeeded(for: $0) }
        self.items.insert(contentsOf: items, at: insertIndex)
    }
    
    // MARK: - Interface
    
    public var itemsCount: Int {
        return items.count
    }
    
    public func itemFor(cellIdentifier: String) -> TableViewAdapterItem? {
        return items.first { $0.cellData?.cellIdentifier == cellIdentifier }
    }
    
    public func generateCellFor<T: TableViewAdapterCell>(item: TableViewAdapterItem) -> T? {
        registerNibIfNeeded(for: item)
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: item.cellReuseIdentifier) as? T
        cell?.cellData = item.cellData
        cell?.fill(data: item.cellData)
        
        return cell
    }
    
    public func scrollTo(cell: TableViewAdapterCell,
                         position: UITableView.ScrollPosition = .none,
                         animated: Bool = true) {
        guard var targetContentOffset = tableView?.contentOffset else { return }
        targetContentOffset.y = cell.frame.origin.y
        tableView?.setContentOffset(targetContentOffset, animated: animated)
    }

    public func scrollTo(item: TableViewAdapterItem,
                         position: UITableView.ScrollPosition = .none,
                         animated: Bool = true,
                         completion: (() -> Void)? = nil) {
        completionAfterScrollViewAnimation = completion
        
        if #available(iOS 11.0, *) {
            tableView?.performBatchUpdates(nil, completion: { [weak self] _ in
                guard let index = self?.items.firstIndex(where: { $0 == item }) else { return }
                self?.tableView?.scrollToRow(at: IndexPath(row: index, section: 0), at: position, animated: animated)
            })
        } else {
            main(delay: 0.3, work: { [weak self] in
                guard let index = self?.items.index(where: { $0 == item }) else { return }
                self?.tableView?.scrollToRow(at: IndexPath(row: index, section: 0), at: position, animated: animated)
            })
        }
    }
    
    public func scrollToImmediately(item: TableViewAdapterItem,
                                    position: UITableView.ScrollPosition = .none,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        completionAfterScrollViewAnimation = completion
        guard let index = items.firstIndex(where: { $0 == item }) else { return }
        tableView?.scrollToRow(at: IndexPath(row: index, section: 0), at: position, animated: animated)
    }
    
    public func firstIndex(forItem item: TableViewAdapterItem) -> Int? {
        return items.firstIndex(where: { $0.cellData?.cellIdentifier == item.cellData?.cellIdentifier })
    }
    
    public func perform(_ updates: (TableViewAdapterUpdater) -> Void) {
        guard let updater = updater else { fatalError("updater is nil") }
        
        updates(updater)
        
        updater.performCommands()
        updater.clearCommands()
    }
    
    public func clear() {
        items.removeAll()
    }
    
    public func reloadData(animated: Bool = false) {
        if animated {
            tableView?.reloadSections(IndexSet(integer: 0), with: .automatic)
        } else {
            tableView?.reloadData()
        }
    }
    
    public func scrollToTop() {
        main { [weak self] in
            self?.tableView?.setContentOffset(CGPoint(x: 0, y: 0),
                                              animated: true)
        }
    }
    
    public func scrollToBottom() {
        main { [weak self] in
            guard let lastItem = self?.items.last else { return }
            self?.scrollTo(item: lastItem, animated: false)
        }
    }
    
    // MARK: - Private
    
    public func registerNibIfNeeded(for item: TableViewAdapterItem) {
        var bundle: Bundle? = nil
        if let cellBundleIdentifier = item.cellBundleIdentifier {
            bundle = Bundle(identifier: cellBundleIdentifier)
            guard bundle != nil else {
                debugPrint("TableViewAdapter: Can't findle bundle with identifier: \(cellBundleIdentifier)")
                return
            }
        }
        let nib = UINib(nibName: item.cellReuseIdentifier, bundle: bundle)
        tableView?.register(nib, forCellReuseIdentifier: item.cellReuseIdentifier)
    }
    
    private func cellAt(_ indexPath: IndexPath) -> TableViewAdapterCell? {
        let item = items[indexPath.row]
        let cellIdentifier = item.cellReuseIdentifier
        let cell = tableView?.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewAdapterCell
        cell?.cellData = item.cellData
        cell?.handler = item.cellHandler
        return cell
    }
    
}

extension TableViewAdapter: UITableViewDelegate {
    
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let cell = cellAt(indexPath) else { return nil}
        return delegate?.tableViewAdapterNeedsActionsForCellEditing(adapter: self, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let item = items.entityAt(indexPath.row) else { return false }
        return item.canEdit()
    }
    
    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
        debugPrint("commit: \(editingStyle)")
        if editingStyle == .delete {
            let cell = cellAt(indexPath)
            guard items.entityAt(indexPath.row) != nil else { return }
            items.remove(at: indexPath.row)
            reloadData(animated: true)
            delegate?.tableViewAdapterUserDidDeleteCell(adapter: self, cell: cell)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        var direction: TableViewAdapterScrollDirection = .none
        let translation = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        direction = translation < 0 ? .down : .up
        
        var contentPosition: TableViewAdapterScrollPosition = .none
        
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentOffsetY <= 0 {
            contentPosition = .top
        } else if contentOffsetY >= contentHeight {
            contentPosition = .bottom
        } else {
            contentPosition = .inside
        }
        
        delegate?.tableViewAdapterTableViewWillScroll(adapter: self, contentPosition: contentPosition, direction: direction)
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = items.entityAt(indexPath.row) else { return 120 }
        return item.height()
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = items.entityAt(indexPath.row) else { return 120 }
        return item.height()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableViewFrame = tableView?.frame else { return }
        guard let contentSize = tableView?.contentSize else { return }
        guard let contentOffset = tableView?.contentOffset else { return }
        
        delegate?.tableViewAdapterTableViewDidScroll(adapter: self, contentOffset: contentOffset)
        
        let contentOffsetBottomPoint = contentOffset.y + tableViewFrame.size.height
        let reachedTop = contentOffset.y < 0
        let reachedBottom = contentOffsetBottomPoint >= contentSize.height
        
        if reachedTop == true {
            let offset = abs(contentOffset.y)
            delegate?.tableViewAdapter(self, didReachBorderPosition: .top, offset: offset)
        }
        else if reachedBottom == true {
            let offset = abs(contentOffsetBottomPoint - contentSize.height)
            delegate?.tableViewAdapter(self, didReachBorderPosition: .bottom, offset: offset)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        completionAfterScrollViewAnimation?()
        completionAfterScrollViewAnimation = nil
    }
    
}

extension TableViewAdapter: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = cellAt(indexPath)
        cell?.delegate = item.cellHandler
        cell?.fill(data: item.cellData)
        
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewAdapterCell else { return }
        
        delegate?.tableViewAdapterCellWillAppear(adapter: self, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView,
                          didEndDisplaying cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewAdapterCell else { return }
        
        delegate?.tableViewAdapterCellWillDissappear(adapter: self, cell: cell)
    }
    
}
