//
//  AlbumDetailViewController.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/6/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    var album: Album

    init(album: Album) {
        self.album = album
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUIAndConstraints()
    }

    func setupUIAndConstraints() {
        let stackView: UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.spacing = 5
            sv.alignment = .center
            return sv
        }()
        let imageView: UIImageView = {
            let iv = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
            iv.layer.cornerRadius = 10
            iv.backgroundColor = .darkGray
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.widthAnchor.constraint(equalToConstant: 200).isActive = true
            iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            if let imageUrlStr = album.artworkUrl100 {
                imageFrom(imageUrlStr) { (imageFetchResult) in
                    switch imageFetchResult {
                    case .success(let image):
                        DispatchQueue.main.async {
                            iv.image = image
                        }
                    case .failure(let error):
                        iv.image = imageFrom(text: "No \nArtwork")
                        print(error.localizedDescription)
                    }
                }
            }
            
            return iv
        }()

        let labelTextColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        let lableTextFont = UIFont.systemFont(ofSize: 18)
        let albumNamelabel: UILabel = {
            let label = UILabel()
            label.text = album.name ?? ""
            return label
        }()
        let artistNamelabel: UILabel = {
            let label = UILabel()
            label.text = album.artistName ?? ""
            return label
        }()
        let genreLabel: UILabel = {
            let label = UILabel()
            var genreString = ""
            album.genres?.forEach {
                genreString += (", " + ($0.name ?? ""))
            }
            if genreString.hasPrefix(", ") {
                genreString = String(genreString.dropFirst(2))
            }
            
            label.text = genreString
            return label
        }()
        
        let releaseDatelabel: UILabel = {
            let label = UILabel()
            label.text = album.releaseDate ?? ""
            return label
        }()
        
        let copyRightlabel: UILabel = {
            let label = UILabel()
            label.text = album.copyright ?? ""
            return label
        }()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(albumNamelabel)
        stackView.addArrangedSubview(artistNamelabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDatelabel)
        stackView.addArrangedSubview(copyRightlabel)
        
        for label in stackView.arrangedSubviews {
            if let label = label as? UILabel {
                label.numberOfLines = 3
                label.font = lableTextFont
                label.textColor = labelTextColor
                label.translatesAutoresizingMaskIntoConstraints = false
                label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            }
        }
        view.addSubview(stackView)
        
        // autolayout constraints
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        let goToiTunesStorePageButton: UIButton = {
            let btn = UIButton(type: .custom)
            btn.setTitle("Go to iTunes Store Page", for: .normal)
            btn.backgroundColor = .brown
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 8
            return btn
        }()
        view.addSubview(goToiTunesStorePageButton)
        goToiTunesStorePageButton.translatesAutoresizingMaskIntoConstraints = false
        goToiTunesStorePageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        goToiTunesStorePageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = false
        goToiTunesStorePageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = false
        goToiTunesStorePageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        goToiTunesStorePageButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
    }
}
