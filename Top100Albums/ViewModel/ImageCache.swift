//
//  ImageCache.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/5/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

func imageFrom(_ urlString: String,
               completion: @escaping ((Result<UIImage, Error>) -> Void)) {
    
    guard let url = URL(string: urlString) else {
        completion(.failure(Errors.invalidURL))
        return
    }
    if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
        completion(.success(imageFromCache))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            completion(.failure(Errors.wrongImageData))
            return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            (statusCode >= 200 && statusCode < 400)  else {
                completion(.failure(Errors.wrongHttpStatusCode))
                return
        }
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let image = UIImage(data: data) {
            imageCache.setObject(image, forKey: urlString as NSString)
            completion(.success(image))
        } else {
            completion(.failure(Errors.wrongImageData))
        }
    }
    
    task.resume()
}
