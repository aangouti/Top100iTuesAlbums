//
//  DataSource.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation
import UIKit

let topAlbumsTableViewCellHeight: CGFloat = 150

class GenericDataSource<T>: NSObject {
    var data = DynamicValue([T]())
}

class DataSource: GenericDataSource<Album>, UITableViewDataSource {
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.estimatedRowHeight = topAlbumsTableViewCellHeight
        // register table view cells here
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data.value[indexPath.row].artistName ?? "No Name"
        return cell
    }
}
