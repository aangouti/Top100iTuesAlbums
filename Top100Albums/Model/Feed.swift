//
//  Feed.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [[String: String]]?
    let copyRight: String?
    let country: String?
    let icon: String?
    let updated: String?
}
