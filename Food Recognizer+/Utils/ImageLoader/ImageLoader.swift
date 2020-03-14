//
//  ImageLoader.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import Nuke

class ImageLoader {
    
    static var cached : [CachedImage] = []
    
    static func loadImage(item: ImageLoaderItem, into imageView: UIImageView, completion: (() -> Void)? = nil) {
        // workaround for lot of 404 loads CFNetwork crashes
        // https://forums.developer.apple.com/thread/110493
        
        guard let url = item.imageURL else {
            main { completion?() }
            return
        }
        if let cachedImage = cached.first(where: { $0.url == url.absoluteString }) {
            imageView.image = cachedImage.image
            completion?()
            return
        }
        
        // check if resource exists
        let checkSession = Foundation.URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        item.contentAvailabilityTask?.cancel()
        item.contentAvailabilityTask = checkSession.dataTask(with: request as URLRequest, completionHandler: { (_, response, _) -> Void in
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                main { completion?() }
                return
            }
            let params = (item: item, imageView: imageView, completion: completion)
            switch httpResponse.statusCode {
            case 200:
                perform200(params)
            case 404:
                perform404(params)
            default:
                main { completion?() }
            }
            
        })
        
        item.contentAvailabilityTask?.resume()
    }
    
    private static func perform404(_ cortage: (item: ImageLoaderItem, imageView: UIImageView, completion: (() -> Void)?)) {
        guard let url = cortage.item.imageURL else { return }
        main {
            cached.append(CachedImage(url: url.absoluteString, image: nil))
            cortage.imageView.image = nil
            cortage.completion?()
        }
    }
    
    private static func perform200(_ cortage: (item: ImageLoaderItem, imageView: UIImageView, completion: (() -> Void)?)) {
        guard let url = cortage.item.imageURL else { return }
        main {
            cortage.item.imageLoadingTask = Nuke.loadImage(
                with: url,
                options: ImageLoadingOptions(placeholder: cortage.item.needPlaceholder ? cortage.item.placeholderImage : nil,
                                             transition: .fadeIn(duration: 0.33)),
                into: cortage.imageView,
                completion: { _ in
                    main {
                        if let image = cortage.imageView.image {
                            cached.append(CachedImage(url: url.absoluteString, image: image))
                        }
                        if cached.count > 100 {
                            cached.removeFirst(cached.count - 100)
                        }
                        cortage.completion?()
                    }
                }
            )
        }

    }
    
}

