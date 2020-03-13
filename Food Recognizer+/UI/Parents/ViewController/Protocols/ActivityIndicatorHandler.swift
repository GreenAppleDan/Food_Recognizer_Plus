//
//  ActivityIndicatorHandler.swift
//  Food Recognizer+
//
//  Created by dev on 13.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

public protocol ActivityIndicatorHandler {
    var activityIndicatorView: ActivityIndicatorView? {get set}
    func startActivityIndicator()
    func stopActivityIndicator()
}
