//
//  API.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation

let top100AlbumsURLString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"

enum Errors: Error {
    case invalidURL
    case noData
    case wrongHttpStatusCode
}

class API {
    class func getTop100Albums(completion: @escaping ((Result<FeedRoot, Error>) -> ())) {
        guard let url = URL(string: top100AlbumsURLString) else {
            completion(.failure(Errors.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(Errors.noData))
                return
            }
            
            guard let response = (response as? HTTPURLResponse)?.statusCode,
                response >= 200, response < 400 else {
                    completion(.failure(Errors.wrongHttpStatusCode))
                    return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let feedRoot = try JSONDecoder().decode(FeedRoot.self, from: data)
                completion(.success(feedRoot))
            } catch(let error) {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
