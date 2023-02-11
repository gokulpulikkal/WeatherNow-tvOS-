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
        imageView.masksFocusEffectToContents = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "transparentBackground")?.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "text"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        let cellContentView = backgroundImageView.overlayContentView
        cellContentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            timeLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 0),
            timeLabel.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 0),
            timeLabel.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: 0)
        ])
        backgroundImageView.overlayContentView.backgroundColor = UIColor(hexString: "#2a2a2a")
        backgroundImageView.overlayContentView.layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
