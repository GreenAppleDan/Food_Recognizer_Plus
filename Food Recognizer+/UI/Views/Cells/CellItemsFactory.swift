//
//  CellItemsFactory.swift
//  True Photo
//
//  Created by Денис Жукоборский on 19.12.2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class CellItemsFactory {
    
    static func imageViewItem(cellIdentifier: String? = nil, image: UIImage?) -> TableViewAdapterItem {
        
        let data = ImageViewCellData(cellIdentifier: cellIdentifier, image: image)
        
        let item = TableViewAdapterItem(cellClass: ImageViewCell.self, cellData: data, cellHandler: nil)
        
        return item
    }
    
    static func singleButtonItem(cellIdentifier: String, backgroundColor: UIColor, buttonText: String, buttonTextColor: UIColor, leadingAndTrailingConstraintsValue: CGFloat =  16, isActive: Bool = true) -> TableViewAdapterItem {
        let data = SingleButtonCellData(cellIdentifier: cellIdentifier, backgroundColor: backgroundColor, buttonText: buttonText, buttonTextColor: buttonTextColor, leadingAndTrailingConstraintsValue: leadingAndTrailingConstraintsValue, isActive: isActive)
        
        let item = TableViewAdapterItem(cellClass: SingleButtonCell.self, cellData: data, cellHandler: TableViewAdapterCellActionHandler())
        
        return item
    }
    
    static public func emptySpaceItem(cellIdentifier: String? = nil,
                                      color: UIColor = .clear,
                                      height: CGFloat? = 44) -> TableViewAdapterItem {
        let cellData = EmptySpaceCellData(cellIdentifier: cellIdentifier,
                                          color: color,
                                          height: height)
        let item = TableViewAdapterItem(cellClass: EmptySpaceCell.self, cellData: cellData)
        
        return item
    }
    
    static public func ingridientProbabilityPredictionItem(cellIdentifier: String? = nil, ingridientName: String, ingridientProbability: Float, isChosen: Bool) -> TableViewAdapterItem {
        let cellData = IngridientProbabilityPredictionCellData(cellIdentifier: cellIdentifier, ingridientName: ingridientName, ingridientProbability: ingridientProbability, isChosen: isChosen)
        let item = TableViewAdapterItem(cellClass: IngridientProbabilityPredictionCell.self, cellData: cellData, cellHandler: IngridientProbabilityPredictionCellActionHandler())
        
        return item
    }
    
    static public func recipeItem(cellIdentifier: String? = nil, recipe: Recipe) -> TableViewAdapterItem {
        
        let imageLoaderItem = ImageLoaderItem(placeholderImage: nil, imageURL: URL(string: recipe.thumbnail ?? ""), needPlaceholder: false)
        let cellData = RecipeCellData(cellIdentifier: cellIdentifier, recipe: recipe, imageLoaderItem: imageLoaderItem)
        let item = TableViewAdapterItem(cellClass: RecipeCell.self, cellData: cellData, cellHandler: RecipeCellActionHandler())
        return item
    }
    
    static public func customTextItem(cellIdentifier: String? = nil,
                                      leftLabelText: String,
                                      leftLabelColor: UIColor = Colors.gray,
                                      rightLabelText: String?,
                                      rightLabelColor: UIColor? = Colors.black,
                                      alternativeImage: UIImage?,
                                      isArrowHidden: Bool = false) -> TableViewAdapterItem {
        let cellData = CustomTextCellData(cellIdentifier: cellIdentifier,
                                          leftLabelText: leftLabelText,
                                          leftLabelColor: leftLabelColor,
                                          rightLabelText: rightLabelText,
                                          rightLabelColor: rightLabelColor,
                                          alternativeImage: alternativeImage,
                                          isArrowHidden: isArrowHidden)
        let item = TableViewAdapterItem(cellClass: CustomTextCell.self, cellData: cellData, cellHandler: TableViewAdapterCellActionHandler())
        return item
    }
    
}
