//
//  PhotoAnalyserViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class PhotoAnalyserViewControllerPresenter: TableViewAdapterPresenter {
    
    private var navigationView: NavigationView?
    private var imagePicker: UIImagePickerController
    private var chosenImage: UIImage?
    
    init(tableViewAdapter: TableViewAdapter?, viewController: UIViewController, navigationView: NavigationView?) {
        self.navigationView = navigationView
        imagePicker = UIImagePickerController()
        super.init(tableViewAdapter: tableViewAdapter, viewController: viewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        tableViewAdapter?.tableView?.separatorStyle = .none
        
        setupNavigationView()
        
        reloadItems()
    }
    
    
    private func setupNavigationView() {
        navigationView?.backButtonIsHidden = true
        navigationView?.set(title: "Analyser")
    }
    
    private func reloadItems(){
        let items = PhotoAnalyserViewControllerItemsFactory.items(photoImage: chosenImage)
        
        set(items: items, animated: false)
    }
}

extension PhotoAnalyserViewControllerPresenter: TableViewAdapterCellActionHandlerDelegate {
    func tableViewAdapterCellDidTap(_ tableViewAdapterCell: TableViewAdapterCell, withIdentifier identifier: String) {
        guard let identifier = PhotoAnalyserViewControllerPresenterItemIdentifier(rawValue: identifier) else { return }
        switch identifier {
        case .choosePhotoFromLibrary:
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return }
            
            imagePicker.sourceType = .savedPhotosAlbum
            viewController?.present(imagePicker, animated: true, completion: nil)
        case .takePicture:
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            
            imagePicker.sourceType = .camera
            viewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension PhotoAnalyserViewControllerPresenter: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true, completion: nil)
        chosenImage = image
        reloadItems()
    }
}
