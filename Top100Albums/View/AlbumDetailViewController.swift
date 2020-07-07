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
        title = album.name ?? ""
        setupUIAndConstraints()
    }

    func setupUIAndConstraints() {
        let stackView: UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.spacing = 10
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

        let labelFirstPartTextColor = #colorLiteral(red: 0.1137254902, green: 0.1960784314, blue: 0.09019607843, alpha: 1)
        let labelSecondPartTextColor = #colorLiteral(red: 0.2078431373, green: 0.3725490196, blue: 0.2078431373, alpha: 1)
        let labelFirstPartFont = UIFont.systemFont(ofSize: 14)
        let firstPartAttributes = [NSAttributedString.Key.font: labelFirstPartFont, NSAttributedString.Key.foregroundColor: labelFirstPartTextColor]
        let labelSecondPartFont = UIFont.systemFont(ofSize: 17)
        let secondPartAttributes = [NSAttributedString.Key.font: labelSecondPartFont,
                                    NSAttributedString.Key.foregroundColor: labelSecondPartTextColor]

        let albumNamelabel: UILabel = {
            let label = UILabel()
            let attStr1 = NSMutableAttributedString(string: "Album Title: \n",
                                                               attributes: firstPartAttributes)
            let attStr2 = NSMutableAttributedString(string: album.name ?? "",
                                                               attributes: secondPartAttributes)
            label.attributedText = combinedAttributedString(attStr1, attStr2)
            return label
        }()
        
        let artistNamelabel: UILabel = {
            let label = UILabel()
            
            let attStr1 = NSMutableAttributedString(string: "Artist: \n",
                                                               attributes: firstPartAttributes)
            let attStr2 = NSMutableAttributedString(string: album.artistName ?? "",
                                                               attributes: secondPartAttributes)
            label.attributedText = combinedAttributedString(attStr1, attStr2)
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
            
            let attStr1 = NSMutableAttributedString(string: "Genre: \n",
                                                               attributes: firstPartAttributes)
            let attStr2 = NSMutableAttributedString(string: genreString,
                                                               attributes: secondPartAttributes)
            label.attributedText = combinedAttributedString(attStr1, attStr2)
            return label
        }()
        
        let releaseDatelabel: UILabel = {
            let label = UILabel()
            
            let attStr1 = NSMutableAttributedString(string: "Release Data: \n",
                                                               attributes: firstPartAttributes)
            let attStr2 = NSMutableAttributedString(string: album.releaseDate ?? "",
                                                               attributes: secondPartAttributes)
            label.attributedText = combinedAttributedString(attStr1, attStr2)
            return label
        }()
        
        let copyRightlabel: UILabel = {
            let label = UILabel()
            
            let attStr1 = NSMutableAttributedString(string: "Copyright: \n",
                                                               attributes: firstPartAttributes)
            let attStr2 = NSMutableAttributedString(string: album.copyright ?? "",
                                                               attributes: secondPartAttributes)
            label.attributedText = combinedAttributedString(attStr1, attStr2)
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
                label.numberOfLines = 4
                label.translatesAutoresizingMaskIntoConstraints = false
                label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                               constant: 0).isActive = true
            }
        }
        view.addSubview(stackView)
        
        // autolayout constraints
        stackView.topAnchor.constraint(equalTo: view.topAnchor,
                                       constant: 75).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -10).isActive = true
        
        let goToiTunesStorePageButton: UIButton = {
            let btn = UIButton(type: .custom)
            btn.setTitle("Go to iTunes Store Page", for: .normal)
            btn.backgroundColor = .brown
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 8
            btn.addTarget(self,
                          action: #selector(goToiTunesStorePageButtonClicked),
                          for: .touchUpInside)
            return btn
        }()
        view.addSubview(goToiTunesStorePageButton)
        goToiTunesStorePageButton.translatesAutoresizingMaskIntoConstraints = false
        goToiTunesStorePageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                          constant: -20).isActive = true
        goToiTunesStorePageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                           constant: 20).isActive = false
        goToiTunesStorePageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20).isActive = false
        goToiTunesStorePageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                           constant: 0).isActive = true
        goToiTunesStorePageButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                         constant: -40).isActive = true
        
    }
    
    @objc func goToiTunesStorePageButtonClicked(button: UIButton) {
        UIView.animate(withDuration: 0.1,
                   delay: 0,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 3,
                   options: [.curveEaseInOut],
                   animations: {
                    button.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        }) { [weak self] _ in
            button.transform = CGAffineTransform.identity
            guard let url = URL(string: self?.album.url ?? "") else { return }
            UIApplication.shared.open(url)
        }
    }
    
    private func combinedAttributedString(_ attStr1: NSAttributedString,
                                          _ attrStr2: NSAttributedString) -> NSAttributedString {
        let combination = NSMutableAttributedString()
        combination.append(attStr1)
        combination.append(attrStr2)
        return combination
    }
}
