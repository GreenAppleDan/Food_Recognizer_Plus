//
//  ImageViewCellData.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class ImageViewCellData: TableViewAdapterItemData {
    var image: UIImage?
    
    init(cellIdentifier: String? = nil, image: UIImage?){
        self.image = image
        
        super.init(cellIdentifier: cellIdentifier)
    }
    
    override func cellHeight() -> CGFloat {
        return UIScreen.main.bounds.height/2
    }
}
