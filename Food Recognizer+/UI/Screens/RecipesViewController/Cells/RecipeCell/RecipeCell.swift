//
//  RecipeCell.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 14.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class RecipeCell: TableViewAdapterCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var ingridientsLabel: UILabel?
    @IBOutlet private weak var foodImage: UIImageView?
    @IBOutlet private weak var arrowImage: UIImageView?
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var overlappingButton: UIButton?
    
    var data: RecipeCellData?
    override func awakeFromNib() {
        separatorView?.backgroundColor = Colors.silver
        
        foodImage?.layer.masksToBounds = true
        foodImage?.layer.cornerRadius = 16
    }
    
    override func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? RecipeCellData else { return }
        
        self.data = data
        titleLabel?.text = (data.recipe.title ?? "").filter { !$0.isNewline && !"\t".contains($0) }.trimmingCharacters(in: .whitespaces)
        ingridientsLabel?.text = "Ingridients: " + (data.recipe.ingredients ?? "")
        
        let shouldCellBeClickable = data.recipe.href != nil ? false : true
        arrowImage?.isHidden = shouldCellBeClickable
        overlappingButton?.isHidden = shouldCellBeClickable
        
        if  let imageView = foodImage {
            ImageLoader.loadImage(item: data.imageLoaderItem, into: imageView)
        }
    }
    
    
    @IBAction func overlappingButtonDidTap(_ sender: UIButton) {
        guard let cellIdentifier = cellData?.cellIdentifier else { return }
        
        let action = TableViewAdapterCellAction(cellIdentifier: cellIdentifier, identifier: RecipeCellActionIdentifier.overlappingButtonDidTap.rawValue, data: (data?.recipe.href, data?.recipe.title))
        delegate?.handle(action, cell: self)
    }
}

