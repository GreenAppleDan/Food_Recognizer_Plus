//
//  CollectionViewAdapterCellAction.swift
//  Food Recognizer+
//
//  Created by dev on 18.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//
import Foundation

public class CollectionViewAdapterCellAction {
    
    public let cell: CollectionViewAdapterCell
    public let cellIdentifier: String
    public let actionIdentifier: String
    public let data: Any?
    
    init(cell: CollectionViewAdapterCell,
         cellIdentifier: String = UUID().uuidString,
         actionIdentifier: String,
         data: Any? = nil) {
        self.cell = cell
        self.cellIdentifier = cellIdentifier
        self.actionIdentifier = actionIdentifier
        self.data = data
    }
}
