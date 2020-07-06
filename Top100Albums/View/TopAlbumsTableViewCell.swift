//
//  TopAlbumsTableViewCell.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/5/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import UIKit

class TopAlbumsTableViewCell: UITableViewCell {

    var album: Album? {
        didSet {
            artworkImageView.image = nil
            if let imageUrlStr = album?.artworkUrl100 {
                imageFrom(imageUrlStr) { [weak self] (imageFetchResult) in
                    switch imageFetchResult {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self?.artworkImageView.image = image
                        }
                    case .failure(let error):
                        #warning("make an image from text")
                        print(error.localizedDescription)
                    }
                }
            }
            
            albumNamelabel.text = album?.name ?? ""
            artistNamelabel.text = album?.artistName ?? ""
        }
    }
    let artworkImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let artworkImageSize = CGSize(width: 100, height: 100)
    
    let albumNamelabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let artistNamelabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style
            , reuseIdentifier: reuseIdentifier)
        addUIElementsAndConstraints()
    }
    
    private func addUIElementsAndConstraints() {
        contentView.addSubview(artworkImageView)
        artworkImageView.frame = CGRect(origin: CGPoint.zero, size: artworkImageSize)
        artworkImageView.backgroundColor = .gray
        artworkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        artworkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        artworkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artworkImageView.widthAnchor.constraint(equalToConstant: artworkImageSize.width).isActive = true
        artworkImageView.heightAnchor.constraint(equalToConstant: artworkImageSize.height).isActive = true
        
        // add artist name and album name to the Stack view
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(albumNamelabel)
        stackView.addArrangedSubview(artistNamelabel)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
