//
//  PhotoAnalyserViewController.swift
//  True Photo
//
//  Created by Денис Жукоборский on 05/12/2019.
//  Copyright © 2019 Денис Жукоборский. All rights reserved.
//

import UIKit
class PhotoAnalyserViewController: BaseViewController<PhotoAnalyserViewControllerPresenter> {
    // MARK: - Properties
    var clarifaiService: ClarifaiService?
    var screensFactory: ScreensFactory?
    
    private var chosenImage: UIImage?
    
    private var imagePicker: UIImagePickerController = UIImagePickerController()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clarifaiService = clarifaiService else { return }
        presenter = PhotoAnalyserViewControllerPresenter(delegate: self, clarifaiService: clarifaiService)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        tableViewAdapter?.tableView?.separatorStyle = .none
        
        setupNavigationView()
        
        reloadItems()
        
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private. Setup
    private func setupNavigationView() {
        navigationView?.backButtonIsHidden = true
        navigationView?.set(title: "Analyser")
    }
    
    private func reloadItems(){
        let items = PhotoAnalyserViewControllerItemsFactory.items(photoImage: chosenImage)
        
        set(items: items, animated: false)
    }
}

extension PhotoAnalyserViewController: TableViewAdapterCellActionHandlerDelegate {
    func tableViewAdapterCellDidTap(_ tableViewAdapterCell: TableViewAdapterCell, withIdentifier identifier: String) {
        guard let identifier = PhotoAnalyserViewControllerPresenterItemIdentifier(rawValue: identifier) else { return }
        switch identifier {
        case .choosePhotoFromLibrary:
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return }
            
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true, completion: nil)
        case .takePicture:
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        case .analysePicture:
            guard let chosenImage = chosenImage else {
                self.showAlert(title: "Image is not chosen")
                return
            }
            activityIndicatorView?.startActivityIndicator()
            presenter?.getFoodPredictions(for: chosenImage)
        }
    }
}

extension PhotoAnalyserViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true, completion: nil)
        chosenImage = image
        reloadItems()
    }
}

extension PhotoAnalyserViewController: PhotoAnalyserViewControllerProtocol {
    func pushFoodPredictionsViewController(predictions: [ClarifaiFoodPrediction]) {
        guard let foodPredictionsViewController = screensFactory?.foodPredictionsViewController(clarifaiPredictions: predictions) else { return }
        pushViewController(foodPredictionsViewController, animated: true)
    }
    
    
}
