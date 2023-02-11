//
//  ForeCastCollectionViewCell.swift
//  WeatherNow
//
//  Created by Gokul P on 03/02/23.
//

import UIKit

class ForeCastCollectionViewCell: UICollectionViewCell {
    static let CELL_IDENTIFIER = "ForeCastCollectionViewCell"
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        backgroundImageView.image = UIImage(named: "nightSky")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.contentMode = .scaleAspectFit
    }
}
