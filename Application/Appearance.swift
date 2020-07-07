//
//  Appearance.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/7/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import UIKit

class Appearance {

  static func configure() {
    let navProxy = UINavigationBar.appearance()
    navProxy.barStyle = .black
    navProxy.tintColor = UIColor(red: 229/255, green: 177/255, blue: 58/255, alpha: 1)
    navProxy.titleTextAttributes = [
      .font: UIFont(name: "Futura-CondensedMedium", size: 20)!
    ]
  }
}
