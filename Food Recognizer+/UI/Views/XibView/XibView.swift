//
//  XibView.swift
//  True Photo
//
//  Created by Денис Жукоборский on 08/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//
import UIKit

open class XibView: UIView {
    
    // MARK: - Properties
    
    public weak var contentView: UIView?
    
    // MARK: - Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = fromNib()
        loadedFromNib()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        contentView = fromNib()
        frame = contentView?.frame ?? frame
        loadedFromNib()
    }
    
    // MARK: - Postflight
    
    open func loadedFromNib() {
        
    }
    
}
