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
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.choosePhotoFromLibrary.rawValue, backgroundColor: Colors.green, buttonText: _L("LNG_CHOOSE_PHOTO"), buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.takePicture.rawValue, backgroundColor: Colors.green, buttonText: _L("LNG_TAKE_A_PICTURE"), buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25))
        
        let analysePictureButtonIsActive = photoImage != nil
        
        items.append(CellItemsFactory.singleButtonItem(cellIdentifier: PhotoAnalyserViewControllerPresenterItemIdentifier.analysePicture.rawValue, backgroundColor: analysePictureButtonIsActive ? Colors.brand : Colors.silver, buttonText: _L("LNG_ANALYSE_CHOSEN_PICTURE"), buttonTextColor: UIColor.white, leadingAndTrailingConstraintsValue: 25, isActive: analysePictureButtonIsActive))
        
        return items
    }
}
