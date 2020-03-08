//
//  ImageViewCell.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
import AVFoundation

class ImageViewCell: TableViewAdapterCell {
    
    @IBOutlet private weak var cellImageView: ScaledHeightImageView?
    @IBOutlet private weak var cellImageViewWidth: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellImageView?.clipsToBounds = true
        cellImageView?.layer.masksToBounds = true
        
        let ratio = (cellImageView?.frame.height ?? 0)/(cellImageView?.image?.size.height ?? 1)
        let imageWidthWithRatioApplied = (cellImageView?.image?.size.width ?? 1) * ratio
        if imageWidthWithRatioApplied < (cellImageViewWidth?.constant ?? 1) {
            cellImageView?.contentMode = .scaleAspectFill
            cellImageViewWidth?.isActive = true
            cellImageViewWidth?.constant = imageWidthWithRatioApplied * 2
        }
        
        cellImageView?.layer.cornerRadius = 16
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? ImageViewCellData else { return }
        cellImageViewWidth?.constant = UIScreen.main.bounds.width - 32
        cellImageView?.image = data.image
    }
}
