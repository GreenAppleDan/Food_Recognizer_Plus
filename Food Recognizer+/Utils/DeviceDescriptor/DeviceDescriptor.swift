//
//  DeviceDescriptor.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

open class DeviceDescriptor {
    // MARK: - Properties
    static public let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    static public let isIphone = UIDevice.current.userInterfaceIdiom == .phone
    static public let isRetina = UIScreen.main.scale >= 2.0
    
    static public let screenWidth = UIScreen.main.bounds.size.width
    static public let screenHeight = UIScreen.main.bounds.size.height
    static public let screenMaxLength = max(screenWidth, screenHeight)
    static public let screenMinLength = min(screenWidth, screenHeight)
    
    static public let isIphone4 = (isIphone && screenMaxLength < 568.0)
    static public let isIphone5 = (isIphone && screenMaxLength == 568.0)
    static public let isIphone6 = (isIphone && screenMaxLength == 667.0)
    static public let isIphone6P = (isIphone && screenMaxLength == 736.0)
    static public let isIphoneX = (isIphone && screenMaxLength == 812.0)
    static public let isBigIphone = (isIphone && screenMaxLength > 568.0)
    
    static public var deviceSize : DeviceSize {
        get {
            if !isIphone { return DeviceSize.big }
            if screenMaxLength <= 568 {
                return DeviceSize.little
            } else if screenMaxLength <= 667 {
                return DeviceSize.middle
            }
            return DeviceSize.big
        }
    }
}
