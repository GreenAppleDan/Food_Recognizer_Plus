//
//  Colors.swift
//  True Photo
//
//  Created by Денис Жукоборский on 18.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

@objc class Colors: NSObject {
    
    class func rgba( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    class func rgb( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return rgba(red, green, blue, 1)
    }
    
    class func grayLevel(_ gray: CGFloat) -> UIColor {
        return rgb(gray, gray, gray)
    }
    
    class func blackAlpha(_ alpha: CGFloat) -> UIColor {
        return rgba(0, 0, 0, alpha)
    }
    
    public static let white = UIColor.white
    public static let green = UIColor(red: 50, green: 200, blue: 50)
    public static let brand = UIColor(red: 255, green: 105, blue: 0)
    public static let silver = UIColor(red: 229, green: 229, blue: 229)
    static public let black = grayLevel(0)
}
