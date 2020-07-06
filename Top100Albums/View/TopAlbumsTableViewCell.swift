//
//  TopAlbumsTableViewCell.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/5/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import UIKit

class TopAlbumsTableViewCell: UITableViewCell {

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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Album Name"
        return label
        }()
    
    let artistNamelabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist Name"
        return label
        }()
    
    let stackView: UIStackView = {
           let sv = UIStackView()
           sv.translatesAutoresizingMaskIntoConstraints = false
           sv.axis = .vertical
           
           return sv
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style
            , reuseIdentifier: reuseIdentifier)
        addUIElements()
        backgroundColor = .yellow
    }
    
    private func addUIElements() {
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
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
