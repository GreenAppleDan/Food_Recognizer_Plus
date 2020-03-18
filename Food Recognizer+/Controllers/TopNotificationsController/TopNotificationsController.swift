//
//  TopNotificationsController.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class TopNotificationsController {
    
    private var topNotificationsCollectionView: TopNotificationsCollectionView
    private weak var view: UIView?
    
    public init (view: UIView?, maxNotificationsAmount: Int) {
        self.topNotificationsCollectionView = TopNotificationsCollectionView(maxNotificationsAmount: maxNotificationsAmount)
        self.view = view
        setupTopNotificationsCollectionView()
    }
    
    public func add(item: TopNotificationsControllerCollectionViewItem) {
        topNotificationsCollectionView.addItem(item: item)
    }
    
    private func setupTopNotificationsCollectionView() {
        topNotificationsCollectionView.isUserInteractionEnabled = false
        topNotificationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view?.addSubview(topNotificationsCollectionView)
        view?.bringSubviewToFront(topNotificationsCollectionView)
        
        let leadingConstraint = NSLayoutConstraint(item: topNotificationsCollectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: topNotificationsCollectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: topNotificationsCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        view?.addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }
}
