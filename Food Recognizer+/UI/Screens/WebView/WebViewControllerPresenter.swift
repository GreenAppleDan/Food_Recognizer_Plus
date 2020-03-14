//
//  WebViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

class WebViewControllerPresenter: TableViewAdapterPresenter<WebViewControllerProtocol> {
    
    private let refference: String?
    
    init(delegate: WebViewControllerProtocol, refference: String?) {
        self.refference = refference
        super.init(delegate: delegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let reference = self.refference {
            if let url = URL(string: reference) {
                delegate?.openURLRequestInWebView(URLRequest(url: url))
            }
        }
    }
}
