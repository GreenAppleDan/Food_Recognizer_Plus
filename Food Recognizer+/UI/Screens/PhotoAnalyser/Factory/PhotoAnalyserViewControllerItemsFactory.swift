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
        
        items.append(CellItemsFactory.emptySpaceItem(height: 30))
        items.append(CellItemsFactory.imageViewItem(image: photoImage))
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.choosePhotoFromLibrary.rawValue, backgroundColor: Colors.green, buttonText: "Choose photo", buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.takePicture.rawValue, backgroundColor: Colors.green, buttonText: "Take a picture", buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        
        let analysePictureButtonIsActive = photoImage != nil
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.analysePicture.rawValue, backgroundColor: analysePictureButtonIsActive ? Colors.brand : Colors.silver, buttonText: "Analyse chosen picture", buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25, isActive: analysePictureButtonIsActive))
        
        return items
    }
}
