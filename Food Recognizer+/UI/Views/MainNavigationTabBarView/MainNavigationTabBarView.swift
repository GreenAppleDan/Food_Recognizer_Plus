//
//  MainNavigationTabBarView.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class MainNavigationTabBarView: XibView {
    
    // MARK: - Properties
    weak var delegate: MainNavigationTabBarViewDelegate?
    
    // MARK: - Properties
    
    private(set) var dataArray: [MainNavigationTabBarButtonViewData] = []
    private var identifierToView: [String : MainNavigationTabBarButtonView] = [:]
    
    // MARK: - Properties
    @IBOutlet private weak var selectedRoundView: UIView?
    @IBOutlet private weak var stackView: UIStackView?
    @IBOutlet private weak var selectedRoundViewWidth: NSLayoutConstraint?
    @IBOutlet private weak var selectedRoundViewXPosition: NSLayoutConstraint?
    // MARK: - Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedRoundView?.addShadow()
        selectedRoundView?.layer.cornerRadius = 36
        stackView?.spacing = 16
    }
    
    // MARK: - Interface
    
    func arrangeStackViewSubviews(){
        if let stackView = stackView {
            for view in stackView.arrangedSubviews {
                stackView.sendSubviewToBack(view)
            }
        }
    }
    
    func add(data: MainNavigationTabBarButtonViewData) {
        dataArray.append(data)
        let buttonView = MainNavigationTabBarButtonView()
        buttonView.delegate = self
        buttonView.fill(data: data)
        buttonView.set(selected: false, animated: false)
        stackView?.addArrangedSubview(buttonView)
        identifierToView[data.identifier] = buttonView
    }
    
    func clear() {
        for data in dataArray {
            let buttonView = identifierToView[data.identifier]
            buttonView?.delegate = nil
            buttonView?.removeFromSuperview()
            identifierToView[data.identifier] = nil
        }
        
        dataArray.removeAll()
    }
    
    func selected() -> String? {
        for key in identifierToView.keys {
            guard let value = identifierToView[key] else { continue }
            if value.isSelected() {
                return key
            }
        }
        
        return nil
    }
    
    func set(selected: Bool, identifier: String, animated: Bool) {
        //guard let selectedRoundViewWidth = selectedRoundViewWidth else { return }
        identifierToView.forEach{ $0.value.set(selected: false, animated: animated) }
        guard let view = identifierToView[identifier] else { return }
        view.set(selected: true, animated: animated)
        let globalPoint = view.superview?.convert(view.frame.origin, to: nil)
        let halfOfViewWidth = view.frame.width/2
        let roundViewWidth = (selectedRoundViewWidth?.constant ?? 0)/2
        selectedRoundViewXPosition?.constant = (globalPoint?.x ?? 0) + halfOfViewWidth - roundViewWidth
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0.1,
                           options: [],
                           animations: { [weak self] in
                            self?.layoutIfNeeded()
                }, completion:nil)
        }
    }
    
}

extension MainNavigationTabBarView: MainNavigationTabBarButtonViewDelegate {
    func mainNavigationTabBarViewButtonDidTap(_ mainNavigationTabBarView: MainNavigationTabBarButtonView, identifier: String) {
        delegate?.mainNavigationTabBarView(self, itemDidTapWithIdentifier: identifier)
    }
}
