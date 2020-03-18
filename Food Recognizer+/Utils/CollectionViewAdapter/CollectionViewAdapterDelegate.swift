//
//  CollectionViewAdapterDelegate.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

public protocol CollectionViewAdapterDelegate: class {
    func collectionViewAdapter(adapter: CollectionViewAdapter, sizeFor item: CollectionViewAdapterItem) -> CGSize
    func collectionViewAdapterEdgeInsets(adapter: CollectionViewAdapter) -> UIEdgeInsets
    func collectionViewAdapterMinimumInterItemSpacing(adapter: CollectionViewAdapter) -> CGFloat
    func collectionViewAdapterTableViewWillScroll(adapter: CollectionViewAdapter,
                                                  contentPosition: CollectionViewAdapterScrollPosition,
                                                  direction: CollectionViewAdapterScrollDirection)
    func collectionViewAdapter(collectionViewAdapter: CollectionViewAdapter, handleAction action: CollectionViewAdapterCellAction)
    func collectionViewAdapter(adapter: CollectionViewAdapter, willDisplayCellAt index: Int)
    func collectionViewAdapter(adapter: CollectionViewAdapter, didEndDisplayingCellAt index: Int)
    func collectionViewAdapterMinimumLineSpacing(adapter: CollectionViewAdapter) -> CGFloat
    func collectionViewAdapterDidScroll(_ collectionViewAdapter: CollectionViewAdapter, didScrollTo contentOffset: CGPoint)
    func collectionViewAdapterDidEndDecelerating(_ collectionViewAdapter: CollectionViewAdapter, contentOffset: CGPoint)
}

public extension CollectionViewAdapterDelegate {
    
    func collectionViewAdapterTableViewWillScroll(adapter: CollectionViewAdapter,
                                                  contentPosition: CollectionViewAdapterScrollPosition,
                                                  direction: CollectionViewAdapterScrollDirection) {
        
    }
    
    func collectionViewAdapterDidScroll(_ collectionViewAdapter: CollectionViewAdapter, didScrollTo contentOffset: CGPoint) {
        
    }
    
    func collectionViewAdapterDidEndDecelerating(_ collectionViewAdapter: CollectionViewAdapter, contentOffset: CGPoint) {
        
    }
    
    func collectionViewAdapter(adapter: CollectionViewAdapter, willDisplayCellAt index: Int) {
        
    }
    
    func collectionViewAdapter(adapter: CollectionViewAdapter, didEndDisplayingCellAt index: Int) {
        
    }
}
