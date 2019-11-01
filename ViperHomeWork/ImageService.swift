//
//  ImageService.swift
//  ViperHomeWork
//
//  Created by Эмиль Шалаумов on 31.10.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

class ImageService {
    var imageCache: UIImage?
    
    func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string:"https://i.pinimg.com/474x/b4/bd/d0/b4bdd071a02bbff4803b67d86aa7984c--cubes.jpg") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let currentError = error {
                completion(nil, currentError)
                return
            }
            
            guard let currentData = data else { return }
            let image = UIImage(data: currentData)
            completion(image, nil)
        }
        
        task.resume()
    }
    
    func saveImageToCache(image: UIImage) {
        imageCache = image
    }
    
    func getImageFromCache() -> UIImage? {
        return imageCache
    }
    
    func clearImageCache() {
        imageCache = nil
    }
}
