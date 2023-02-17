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
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.adjustsImageWhenAncestorFocused = false
        imageView.masksFocusEffectToContents = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Clear")
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "timeLabel"
        return label
    }()
    
    lazy var weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "weatherConditionLabel"
        return label
    }()
    
    lazy var highestTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "H: 21"
        return label
    }()
    
    lazy var lowestTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "L: 10"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        backgroundImageView.overlayContentView.backgroundColor = UIColor(hexString: "#2a2a2a")
        backgroundImageView.overlayContentView.layer.cornerRadius = 10
        
        let cellContentView = backgroundImageView.overlayContentView
        let topStackView = getStackView(axis: .vertical)
        topStackView.addArrangedSubview(timeLabel)
        topStackView.addArrangedSubview(weatherConditionLabel)
        
        let temperaturesStackView = getStackView(axis: .vertical, itemSpacing: 2)
        temperaturesStackView.addArrangedSubview(highestTempLabel)
        temperaturesStackView.addArrangedSubview(lowestTempLabel)
        
        let weatherImageStackView = getStackView(axis: .horizontal, alignment: .center)
        weatherImageStackView.addArrangedSubview(temperaturesStackView)
        weatherImageStackView.addArrangedSubview(weatherImageView)
        weatherImageStackView.distribution = .fillEqually
        
        let rootStackView = getStackView(axis: .vertical)
        rootStackView.addArrangedSubview(topStackView)
        rootStackView.addArrangedSubview(weatherImageStackView)
        
        cellContentView.addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
        
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
    
    func getStackView(axis: NSLayoutConstraint.Axis = .vertical, alignment: UIStackView.Alignment = .leading, itemSpacing: CGFloat = 5) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = alignment
        stackView.spacing = itemSpacing
        return stackView
    }
}
