//
//  PhotoAnalyserViewControllerPresenter.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit

class PhotoAnalyserViewControllerPresenter: TableViewAdapterPresenter {
    
    private weak var navigationView: NavigationView?
    private weak var activityIndicatorView: ActivityIndicatorView?
    private var clarifaiService: ClarifaiService
    private var imagePicker: UIImagePickerController
    private var chosenImage: UIImage?
    
    init(tableViewAdapter: TableViewAdapter?, viewController: UIViewController, navigationView: NavigationView?, activityIndicatorView: ActivityIndicatorView?, clarifaiService: ClarifaiService) {
        self.navigationView = navigationView
        self.activityIndicatorView = activityIndicatorView
        self.clarifaiService = clarifaiService
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
        case .analysePicture:
            guard let chosenImage = chosenImage else {
                viewController?.showAlert(title: "Image is not chosen")
                return
            }
            activityIndicatorView?.startActivityIndicator()
            clarifaiService.getFoodPredictions(from: chosenImage) { (result) in
                self.activityIndicatorView?.stopActivityIndicator()
                if let error = result.1 {
                    self.viewController?.show(error)
                } else if let predictions = result.0 {
                    for prediction in predictions {
                        print(prediction.name)
                    }
                }
            }
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
