//
//  WebViewControllerProtocol.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

protocol WebViewControllerProtocol: ViewControllerProtocol {
    func openURLRequestInWebView(_ urlRequest: URLRequest)
}
