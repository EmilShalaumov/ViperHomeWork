//
//  ImageConfigurator.swift
//  ViperHomeWork
//
//  Created by Эмиль Шалаумов on 31.10.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

protocol ImageConfiguratorProtocol {
    func configure(with viewController: ViewController)
}

class ImageConfigurator: ImageConfiguratorProtocol {
    func configure(with viewController: ViewController) {
        let presenter = ImagePresenter(view: viewController)
        let interactor = ImageInteractor(presenter: presenter)
        
        viewController.imagePresenter = presenter
        presenter.interactor = interactor
    }
}
