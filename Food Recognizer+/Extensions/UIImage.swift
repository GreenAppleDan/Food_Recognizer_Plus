//
//  UIImage.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

extension UIImage {
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func compareTo(_ image: UIImage) -> Bool{
        return self.pngData() == image.pngData()
    }
    
}
