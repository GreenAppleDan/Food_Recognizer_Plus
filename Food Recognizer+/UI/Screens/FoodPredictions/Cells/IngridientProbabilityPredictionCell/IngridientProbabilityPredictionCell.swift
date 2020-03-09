//
//  IngridientProbabilityPredictionCell.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 09.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit

class IngridientProbabilityPredictionCell : TableViewAdapterCell {
    
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var probabilityLabel: UILabel?
    @IBOutlet private weak var viewWithImage: UIImageView?
    @IBOutlet private weak var overlayingButton: UIButton?
    @IBOutlet private weak var separatorView: UIView?
    
    
    public var data: IngridientProbabilityPredictionCellData?
    public var isChosen: Bool = false
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = Colors.silver
    }
    
    override func fill(data: TableViewAdapterItemData?) {
        guard let data = data as? IngridientProbabilityPredictionCellData else { return }
        self.data = data
        nameLabel?.text = data.ingridientName
        probabilityLabel?.text = String(format: "%.2f", data.ingridientProbability)
        self.isChosen = data.isChosen
        viewWithImage?.isHidden = !data.isChosen
    }
    
    public func toggleSelection() {
        isChosen = !isChosen
        data?.isChosen = isChosen
        viewWithImage?.isHidden = !isChosen
    }
    
    @IBAction func overlayingButtonDidTap(_ sender: Any) {
        notify(actionWithIdentifier: IngridientProbabilityPredictionCellActionIdentifier.buttonDidTap.rawValue)
    }
}
