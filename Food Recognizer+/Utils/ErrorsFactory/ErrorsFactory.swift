//
//  ErrorsFactory.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
class ErrorsFactory {
    static public func unknownError() -> Error {
        let userInfo = [NSLocalizedDescriptionKey: "Unknown Error. Please try again"]
        let error = NSError(domain: "HTTP-CLIENT DOMAIN", code: 1, userInfo: userInfo)
        return error
    }
}
