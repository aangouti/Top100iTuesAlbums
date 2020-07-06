//
//  DataSource.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation
import UIKit

let topAlbumsTableViewCellHeight: CGFloat = 110

class GenericDataSource<T>: NSObject {
    var data = DynamicValue([T]())
}

class DataSource: GenericDataSource<Album>, UITableViewDataSource {
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = topAlbumsTableViewCellHeight
        // register table view cells here
        tableView.register(TopAlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = topAlbumsTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopAlbumsTableViewCell
        let album = data.value[indexPath.row]
        
        cell.imageView?.image = nil
        if let imageUrlStr = album.artworkUrl100 {
            imageFrom(imageUrlStr) { (imageFetchResult) in
                switch imageFetchResult {
                case .success(let image):
                    DispatchQueue.main.async {
                        if let cellToUpdate = tableView.cellForRow(at: indexPath) as? TopAlbumsTableViewCell {
                            cellToUpdate.imageView?.image = image
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        cell.textLabel?.text = album.artistName ?? "No Name"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        topAlbumsTableViewCellHeight
    }
}
