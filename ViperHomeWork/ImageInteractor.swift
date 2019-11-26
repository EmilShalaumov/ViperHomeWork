//
//  ImageInteractor.swift
//  ViperHomeWork
//
//  Created by Эмиль Шалаумов on 31.10.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

protocol ImageInteractorOutput {
    func updateImage(image: UIImage)
    func showAlertController(title: String, message: String)
}

protocol ImageInteractorInput {
    func downloadImage()
    func clearCache()
    func showImageFromCache()
}

class ImageInteractor: ImageInteractorInput {
    var presenter: ImageInteractorOutput
    var service: ImageServiceProtocol
    
    init(presenter: ImageInteractorOutput, service: ImageServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func showImageFromCache() {
        if let image = service.imageCache {
            presenter.updateImage(image: image)
            return
        }
        presenter.showAlertController(title: "Fail", message: "Cache is empty")
    }
    
    func downloadImage() {
        service.downloadImage { image, error in
            if let image = image {
                self.service.imageCache = image
                DispatchQueue.main.async {
                    self.presenter.showAlertController(title: "Success", message: "Image downloaded")
                }
            } else {
                DispatchQueue.main.async {
                    self.presenter.showAlertController(title: "Fail", message: "Image failed to download")
                }
            }
        }
    }
    
    func clearCache() {
        service.imageCache = nil
        presenter.updateImage(image: UIImage())
        presenter.showAlertController(title: "Success", message: "Cache is cleared")
    }
}
