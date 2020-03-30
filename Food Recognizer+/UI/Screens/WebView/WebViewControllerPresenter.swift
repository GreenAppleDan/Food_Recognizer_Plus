//
//  WebViewControllerPresenter.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import WebKit
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
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
}
