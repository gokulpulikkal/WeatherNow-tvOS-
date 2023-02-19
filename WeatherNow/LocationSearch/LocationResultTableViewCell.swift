//
//  LocationResultTableViewCell.swift
//  WeatherNow
//
//  Created by Gokul P on 19/02/23.
//

import UIKit

class LocationResultTableViewCell: UITableViewCell {
    
    static let CELL_IDENTIFIER = "LocationResultTableViewCell"
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        if context.nextFocusedView == self {
            cityNameLabel.textColor = .black
        } else {
            cityNameLabel.textColor = .white
        }
    }

}
