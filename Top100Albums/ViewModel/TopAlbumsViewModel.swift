//
//  TopAlbumsViewModel.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation

struct TopAlbumsViewModel {
    weak var dataSource: GenericDataSource<Album>?
    
    var errorHandler: ((Error?) -> ())?
    
    init(dataSource: GenericDataSource<Album>?) {
        self.dataSource = dataSource
    }
    
    func fetchTopAlbums() {
        API.getTop100Albums { (result) in
            switch result {
            case .success(let feedRoot):
                DispatchQueue.main.async {
                    self.dataSource?.data.value = feedRoot.feed.albums ?? []
                }
            case .failure(let error):
                self.errorHandler?(error)
            }
        }
    }
}
