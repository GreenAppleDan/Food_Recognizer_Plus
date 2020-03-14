//
//  ImageLoaderItem.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import Nuke

class ImageLoaderItem {
    
    let placeholderImage: UIImage?
    let imageURL: URL?
    
    let needPlaceholder: Bool
    
    var contentAvailabilityTask: URLSessionDataTask?
    var imageLoadingTask: ImageTask?
    
    init(placeholderImage: UIImage?, imageURL: URL? = nil, needPlaceholder: Bool = true) {
        self.placeholderImage = placeholderImage
        self.imageURL = imageURL
        self.needPlaceholder = needPlaceholder
    }
    
}
