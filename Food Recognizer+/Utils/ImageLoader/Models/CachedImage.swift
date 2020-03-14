//
//  CachedImage.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class CachedImage {
    
    public let url : String
    public let image : UIImage?
    
    public init(url: String, image: UIImage?) {
        self.url = url
        self.image = image
    }
    
}
