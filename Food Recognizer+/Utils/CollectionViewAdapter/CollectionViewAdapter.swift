//
//  CollectionViewAdapter.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public class CollectionViewAdapter: NSObject {
    
    // MARK: - Properties
    
    public var items: [CollectionViewAdapterItem] = []
    public weak var collectionView: UICollectionView?
    var indexToVisibleCellMap: [Int : CollectionViewAdapterCell] = [:]
    public var isScrollEnabled: Bool {
        get {
            return collectionView?.isScrollEnabled ?? false
        }
        
        set {
            collectionView?.isScrollEnabled = newValue
        }
    }
    
    // MARK: - Delegate
    
    private weak var delegate: CollectionViewAdapterDelegate?
    
    // MARK: - Initialization
    
    public init(collectionView: UICollectionView?, delegate: CollectionViewAdapterDelegate? = nil) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.delegate = delegate
    }
    
    // MARK: - Interface
    
    public func visibleCell(at index: Int) -> CollectionViewAdapterCell? {
        return indexToVisibleCellMap[index]
    }
    
    public func set(items: [CollectionViewAdapterItem]) {
        items.forEach {
            registerNibIfNeeded(for: $0)
        }
        self.items = items
        reloadData()
    }
    
    public func add(items: [CollectionViewAdapterItem]) {
        var indexPaths = [IndexPath]()
        
        for item in items {
            registerNibIfNeeded(for: item)
        }
        
        collectionView?.performBatchUpdates({
            for item in items {
                self.items.append(item)
                indexPaths.append(IndexPath(row: self.items.count - 1, section: 0))
            }
            collectionView?.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    public func clear() {
        items = []
        collectionView?.reloadData()
    }
    
    public func reloadData() {
        collectionView?.reloadData()
    }
    
    public func scrollTo(index: Int, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard index >= 0 && index < items.count else { return }
        collectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: scrollPosition, animated: animated)
    }
    
    // MARK: - Private
    
    internal func registerNibIfNeeded(for item: CollectionViewAdapterItem) {
        var bundle: Bundle? = nil
        if let cellBundleIdentifier = item.cellBundleIdentifier {
            bundle = Bundle(identifier: cellBundleIdentifier)
            guard bundle != nil else {
                fatalError("TableViewAdapter: Can't findle bundle with identifier: \(cellBundleIdentifier)")
            }
        }
        let nib = UINib(nibName: item.cellIdentifier, bundle: bundle)
        collectionView?.register(nib, forCellWithReuseIdentifier: item.cellIdentifier)
    }
    
    internal func cellAt(_ indexPath: IndexPath) -> CollectionViewAdapterCell? {
        let item = items[indexPath.row]
        
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier, for: indexPath) as? CollectionViewAdapterCell
        
        cell?.cellData = item.cellData
        return cell
    }
    
    internal func moveItem(from: Int, to: Int) {
        guard from >= 0 && from <= items.count - 1 else { return }
        guard to >= 0 && to <= items.count - 1 else { return }
        
        let item = items[from]
        items.remove(at: from)
        items.insert(item, at: to)
    }
    
}

extension CollectionViewAdapter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewAdapterCell else { return }
        let index = indexPath.row
        indexToVisibleCellMap[index] = cell
        delegate?.collectionViewAdapter(adapter: self, willDisplayCellAt: index)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               didEndDisplaying cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        let index = indexPath.row
        indexToVisibleCellMap.removeValue(forKey: index)
        delegate?.collectionViewAdapter(adapter: self, didEndDisplayingCellAt: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = cellAt(indexPath)
        cell?.fill(data: item.cellData)
        cell?.cellData = item.cellData
        cell?.delegate = self

        return cell ?? UICollectionViewCell()
    }
}

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let delegate = delegate {
            let item = items[indexPath.row]
            return delegate.collectionViewAdapter(adapter: self,
                                                  sizeFor: item)
        }
        
        return CGSize(width: 128, height: 128)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if let delegate = delegate {
            return delegate.collectionViewAdapterMinimumLineSpacing(adapter: self)
        }
        
        return 0.1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if let delegate = delegate {
            return delegate.collectionViewAdapterMinimumInterItemSpacing(adapter: self)
        }
        
        return 8
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if let delegate = delegate {
            return delegate.collectionViewAdapterEdgeInsets(adapter: self)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension CollectionViewAdapter: CollectionViewAdapterCellDelegate {
    public func handle(action: CollectionViewAdapterCellAction) {
        delegate?.collectionViewAdapter(collectionViewAdapter: self, handleAction: action)
    }
}

extension CollectionViewAdapter: UICollectionViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        var direction: CollectionViewAdapterScrollDirection = .none
        
        let translation = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        if translation < 0 {
            direction = .down
        } else {
            direction = .up
        }
        
        var contentPosition: CollectionViewAdapterScrollPosition = .none
        
        let contentOffsetY = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        
        if contentOffsetY <= 0 {
            contentPosition = .top
        }
        else if contentOffsetY >= contentSizeHeight {
            contentPosition = .bottom
        }
        else {
            contentPosition = .inside
        }
        
        delegate?.collectionViewAdapterTableViewWillScroll(adapter: self,
                                                           contentPosition: contentPosition,
                                                           direction: direction)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.collectionViewAdapterDidScroll(self, didScrollTo: scrollView.contentOffset)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.collectionViewAdapterDidEndDecelerating(self, contentOffset: scrollView.contentOffset)
    }
}

