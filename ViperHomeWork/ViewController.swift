//
//  ViewController.swift
//  ViperHomeWork
//
//  Created by Эмиль Шалаумов on 31.10.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImagePresenterOutput {
    
    static let componentWidth = 200
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: componentWidth, height: componentWidth))
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let showButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: componentWidth, height: 40))
        button.backgroundColor = .white
        button.setTitle("Show Image", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(showImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: componentWidth, height: 40))
        button.backgroundColor = .white
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: componentWidth, height: 40))
        button.backgroundColor = .white
        button.setTitle("Clear Cache", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var imagePresenter: ImagePresenterInput?
    let configurator: ImageConfiguratorProtocol = ImageConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        view.backgroundColor = .lightGray
        
        imageView.center = CGPoint(x: view.center.x, y: view.center.y - 130)
        showButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        downloadButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        clearButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        
        view.addSubview(showButton)
        view.addSubview(imageView)
        view.addSubview(downloadButton)
        view.addSubview(clearButton)
    }
    
    @objc func showImageButtonTapped() {
        imagePresenter?.showImageButtonTapped()
    }
    
    @objc func downloadButtonTapped() {
        imagePresenter?.downloadButtonTapped()
    }
    
    @objc func clearButtonTapped() {
        imagePresenter?.clearButtonTapped()
    }

    func updateImage(image: UIImage) {
        imageView.image = image
    }
    
    func presentAlert(alertVC: UIAlertController) {
        self.present(alertVC, animated: true, completion: nil)
    }
}

