//
//  ImagePresenter.swift
//  ViperHomeWork
//
//  Created by Эмиль Шалаумов on 31.10.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

protocol ImagePresenterInput {
    func downloadButtonTapped()
    func clearButtonTapped()
    func showImageButtonTapped()
}

protocol ImagePresenterOutput {
    func updateImage(image: UIImage)
    func presentAlert(alertVC: UIAlertController)
}

class ImagePresenter: ImagePresenterInput, ImageInteractorOutput {
    
    let view: ImagePresenterOutput
    var interactor: ImageInteractorInput?
    
    init(view: ImagePresenterOutput) {
        self.view = view
    }
    
    func showImageButtonTapped() {
        interactor?.showImageFromCache()
    }
    
    func downloadButtonTapped() {
        interactor?.downloadImage()
    }
    
    func clearButtonTapped() {
        interactor?.clearCache()
    }
    
    func updateImage(image: UIImage) {
        view.updateImage(image: image)
    }
    
    func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        view.presentAlert(alertVC: alertController)
    }
}
