//
//  TopNotificationsCollectionView.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class TopNotificationsCollectionView: XibView {
    // MARK: - Properties
    private var collectionViewAdapter: CollectionViewAdapter?
    
    private var maxNotificationsAmount: Int = 3
    // MARK: - Outlets
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint?
    @IBOutlet private weak var collectionView: UICollectionView?
    
    public init(maxNotificationsAmount: Int){
        super.init()
        self.maxNotificationsAmount = maxNotificationsAmount
        collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    public func addItem(item: CollectionViewAdapterItem) {
        guard let collectionViewAdapter = collectionViewAdapter else { return }
        if collectionViewAdapter.items.count >= maxNotificationsAmount {
                collectionViewAdapter.items.remove(at: 0)
                collectionViewAdapter.collectionView?.deleteItems(at: [IndexPath(row: 0, section: 0)])
        }
        collectionViewAdapter.add(items: [item])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            if let index = collectionViewAdapter.items.firstIndex(of: item){
                collectionViewAdapter.items.remove(at: index)
                collectionViewAdapter.collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
                
            }
        }
    }
    
}

extension TopNotificationsCollectionView: CollectionViewAdapterDelegate {
    func collectionViewAdapter(collectionViewAdapter: CollectionViewAdapter, handleAction action: CollectionViewAdapterCellAction) {
    }
    
    func collectionViewAdapter(adapter: CollectionViewAdapter, sizeFor item: CollectionViewAdapterItem) -> CGSize {
        return CGSize(width: DeviceDescriptor.screenWidth - 16, height: 64)
    }
    
    func collectionViewAdapterEdgeInsets(adapter: CollectionViewAdapter) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionViewAdapterMinimumInterItemSpacing(adapter: CollectionViewAdapter) -> CGFloat {
        return 5
    }
    
    func collectionViewAdapterMinimumLineSpacing(adapter: CollectionViewAdapter) -> CGFloat {
        return 5
    }
    
    
}

