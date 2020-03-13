//
//  ViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

open class ViewController<T>: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet public weak var tableView: UITableView?
    @IBOutlet weak var navigationView: NavigationView?
    @IBOutlet public weak var activityIndicatorView: ActivityIndicatorView?
    
    public var tableViewAdapter: TableViewAdapter?
    public var presenter: T?

    private var isShouldScrollTableViewOnKeyboardAppearanceFlag: Bool = true

        
    override open func viewDidLoad() {
        super.viewDidLoad()

        tableViewAdapter = TableViewAdapter(tableView: tableView, delegate: self)

        navigationView?.delegate = self

        tableView?.keyboardDismissMode = .onDrag

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

//    open func viewWillAppear(isNavigationBarHidden: Bool, hidesShadow: Bool) {
//        guard let navigationController = navigationController else { return }
//
//        if hidesShadow == true {
//            let navigationBar = navigationController.navigationBar
//            let hidesShadow = "hidesShadow"
//            if navigationBar.containsValue(hidesShadow) {
//                navigationBar.setValue(true, forKey: hidesShadow)
//            }
//        }
//
//        if navigationController.isNavigationBarHidden == !isNavigationBarHidden {
//            navigationController.setNavigationBarHidden(isNavigationBarHidden, animated: true)
//        }
//
//        presenter?.viewWillAppear(isNavigationBarHidden: true)
//    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        navigationController?.interactivePopGestureRecognizer?.delegate = self

        isShouldScrollTableViewOnKeyboardAppearanceFlag = true

        tableViewAdapterPresenter()?.viewWillAppear()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        isShouldScrollTableViewOnKeyboardAppearanceFlag = false

        tableViewAdapterPresenter()?.viewWillDisappear()
    }

    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        tableViewAdapterPresenter()?.detach()
        super.dismiss(animated: flag, completion: completion)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            debugPrint("interactivePopGestureRecognizer: \(self)")
            return tableViewAdapterPresenter()?.isShouldSwipeOut() ?? false
        }
        return false
    }
    
    // MARK: - Manual cell handling
    
    public func handle(action: TableViewAdapterCellAction) {
        let cell = visibleCellWithIdentifier(action.cellIdentifier)
        cell?.handler?.handle(action, cell: cell)

        tableViewAdapterPresenter()?.handleAction(action)
    }
    
    // MARK: - NormalizingPresenter
    func tableViewAdapterPresenter() -> TableViewAdapterPresenterProtocol? {
        return presenter as? TableViewAdapterPresenterProtocol
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
        if isShouldScrollTableViewOnKeyboardAppearanceFlag {
            guard var tableViewContentOffset = tableViewAdapter?.tableView?.contentOffset else { return }
            tableViewContentOffset.y += tableViewContentOffset.y + keyboardTopY
            tableViewAdapter?.tableView?.setContentOffset(tableViewContentOffset, animated: true)
        }
    }

    // MARK: - Safe Area

    public var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets()
        }
        else {
            return UIEdgeInsets()
        }
    }

    // MARK: - Private

    
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }

    private func visibleCellWithIdentifier(_ identifier: String) -> TableViewAdapterCell? {
        guard
            let visibleCells = tableView?.visibleCells as? [TableViewAdapterCell]
        else {
            return nil
        }

        return visibleCells.filter {($0.cellData?.cellIdentifier == identifier)}.first
    }

}

extension ViewController: ViewControllerProtocol {
    
    // MARK: - ActivityIndicatorHandler
    public func startActivityIndicator() {
        activityIndicatorView?.startActivityIndicator()
    }
    
    public func stopActivityIndicator() {
        activityIndicatorView?.stopActivityIndicator()
    }
    
    // MARK: - ViewControllerProtocol

    public func setNavigationViewTitle(_ title: String, font: UIFont? = nil) {
        navigationView?.set(title: title)
    }

    public func setNavigationViewRightButton(title: String?, image: UIImage?) {
        navigationView?.setRightButton(title: title,
                                       image: image)
    }

    public func setNavigationViewLeftButton(title: String?, image: UIImage?) {
        navigationView?.setLeftButton(title: title,
                                      image: image)
    }

    public func setNavigationViewRightButtonIsHidden(_ isHidden: Bool) {
        navigationView?.rightButtonIsHidden = isHidden
    }

    public func setNavigationViewLeftButtonIsHidden(_ isHidden: Bool) {
        navigationView?.backButtonIsHidden = isHidden
    }

    public func set(items: [TableViewAdapterItem], reload: Bool = true , animated: Bool = false) {
        tableViewAdapter?.clear()
        items.forEach {
            tableViewAdapter?.unsafeAdd(item: $0)
            $0.cellHandler?.delegate = self
        }
        if reload { reloadData(animated: animated) }
    }

    public func reloadData(animated: Bool) {
        tableViewAdapter?.reloadData(animated: animated)
    }
    
    // MARK: - AlertHandler
    public func showAlert(title: String, message: String?, completion: (() -> Void)?) {
        
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                if let completion = completion {
                    completion()
                }
            }
        )
        
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func show(_ error: Error) {
        showAlert(title: error.localizedDescription)
    }
    
    public func showPrompt(title: String,
                           message: String? = nil,
                           yesBlock: @escaping ()-> Void) {
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(
            title: "YES",
            style: .destructive,
            handler: { (_) in
                yesBlock()
            }
        )
        
        let noAction = UIAlertAction(
            title: "NO",
            style: .cancel,
            handler: nil
        )
        
        alertViewController.addAction(yesAction)
        alertViewController.addAction(noAction)
        present(alertViewController, animated: true, completion: nil)

    }
    
}

extension ViewController: ViewControllerRouter {
    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    public func popViewController(animated: Bool) {
        let viewController = navigationController?.popViewController(animated: animated) as? ViewController
        viewController?.tableViewAdapterPresenter()?.detach()
    }
    
    public func dissmiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
}

extension ViewController: TableViewAdapterDelegate {
    public func tableViewAdapterTableViewDidScroll(adapter: TableViewAdapter, contentOffset: CGPoint) {
        tableViewAdapterPresenter()?.tableViewAdapterTableViewDidScroll(adapter: adapter,
                                                                        contentOffset: contentOffset)
    }
    
    public func tableViewAdapterTableViewWillScroll(adapter: TableViewAdapter, contentPosition: TableViewAdapterScrollPosition, direction: TableViewAdapterScrollDirection) {
        tableViewAdapterPresenter()?.tableViewAdapterTableViewWillScroll(adapter: adapter,
                                                                         contentPosition: contentPosition,
                                                                         direction: direction)
    }
    
    public func tableViewAdapterCellWillAppear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {

    }
    
    public func tableViewAdapterCellWillDissappear(adapter: TableViewAdapter, cell: TableViewAdapterCell) {

    }

    
    public func tableViewAdapter(_ adapter: TableViewAdapter, didReachBorderPosition borderPosition: TableViewAdapterBorderPosition, offset: CGFloat) {
        tableViewAdapterPresenter()?.tableViewAdapter(adapter, didReachBorderPosition: borderPosition, offset: offset)
    }
    
}

extension ViewController: NavigationViewDelegate {

    func navigationViewDidTapBackButton(_ view: NavigationView) {
        
    }

    func navigationViewDidTapRightButton(_ view: NavigationView) {

    }

}

extension ViewController: TableCellActionHandlerDelegate {

}
