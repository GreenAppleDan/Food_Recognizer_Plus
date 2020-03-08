//
//  PhotoAnalyserViewControllerItemsFactory.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class PhotoAnalyserViewControllerItemsFactory {
    
    static func items(photoImage: UIImage?) -> [TableViewAdapterItem] {
        
        var items = [TableViewAdapterItem]()
        
        items.append(CellItemsFactory.imageViewItem(image: photoImage))
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.choosePhotoFromLibrary.rawValue, backgroundColor: UIColor(red: 50, green: 200, blue: 50), buttonText: "Choose photo", buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.takePicture.rawValue, backgroundColor: UIColor(red: 50, green: 200, blue: 50), buttonText: "Take a picture", buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        return items
    }
}
