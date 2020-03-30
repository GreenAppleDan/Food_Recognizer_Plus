//
//  WebViewController.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import WebKit
import SwiftUI
class WebViewController: BaseViewController<WebViewControllerPresenter> {
    // MARK: - Outlets
    @IBOutlet private weak var webView: WKWebView?
    
    // MARK: - Properties
    public var refference: String?
    public var navigationBarTitle: String?
    
    private var swiftUIView = UIHostingController(rootView: ContainerWithActivityIndicatorSwiftUI())
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WebViewControllerPresenter(delegate: self, refference: refference)
        
        webView?.navigationDelegate = self
        webView?.isHidden = true
        setupNavigationView()
        presenter?.viewDidLoad()
          
    }
    
    deinit {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationView = navigationView, let webView = webView else { return }
        swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUIView.navigationController?.navigationBar.layer.zPosition = -1
        self.view.addSubview(swiftUIView.view)
        let leadingConstraint = NSLayoutConstraint(item: swiftUIView.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: swiftUIView.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: swiftUIView.view!, attribute: .top, relatedBy: .equal, toItem: navigationView, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: swiftUIView.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 40)
        view.addConstraints([leadingConstraint, trailingConstraint, bottomConstraint, topConstraint])
        view.bringSubviewToFront(webView)
        //swiftUIView.view.frame = self.view.bounds
    }
    
    // MARK: - Setup
    override func setupNavigationView() {
        setNavigationViewRightButtonIsHidden(true)
        setNavigationViewTitle(navigationBarTitle ?? _L("LNG_WEBSITE"))
    }
}


extension WebViewController: WebViewControllerProtocol {
    func openURLRequestInWebView(_ urlRequest: URLRequest) {
        webView?.load(urlRequest)
    }
    
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        swiftUIView.view.removeFromSuperview()
        webView.isHidden = false
    }
}
