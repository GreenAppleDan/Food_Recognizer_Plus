//
//  WebViewController.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController<WebViewControllerPresenter> {
    // MARK: - Outlets
    @IBOutlet private weak var webView: WKWebView?
    
    // MARK: - Properties
    public var refference: String?
    public var navigationBarTitle: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WebViewControllerPresenter(delegate: self, refference: refference)
        
        setupNavigationView()
        presenter?.viewDidLoad()
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
