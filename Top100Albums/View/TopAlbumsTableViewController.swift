//
//  TopAlbumsTableViewController.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import UIKit

class TopAlbumsTableViewController: UITableViewController {

    let dataSource = DataSource()
    
    lazy var viewModel: TopAlbumsViewModel = {
        let viewModel = TopAlbumsViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Albums"
        dataSource.configure(with: tableView)
        
        dataSource.data.addAndNotify(self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        // add error handling
        viewModel.errorHandler = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured",
                                               message: "Oops, something went wrong!",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        viewModel.fetchTopAlbums()
        
        configure()
    }
    
    func configure() {
        
    }
}
