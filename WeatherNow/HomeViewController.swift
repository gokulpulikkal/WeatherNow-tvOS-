//
//  ViewController.swift
//  WeatherNow
//
//  Created by Gokul P on 02/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStatusImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var highestTemperatureLabel: UILabel!
    @IBOutlet weak var lowestTemperatureLabel: UILabel!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    lazy var forecastCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLayout())
        collectionView.register(ForeCastCollectionViewCell.self, forCellWithReuseIdentifier: ForeCastCollectionViewCell.CELL_IDENTIFIER)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        view.backgroundColor = .darkGray
    }

    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 430, height: 220)
        return layout
    }
    
    private func setUpCollectionView() {
        view.addSubview(forecastCollectionView)
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor),
            forecastCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            forecastCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForeCastCollectionViewCell.CELL_IDENTIFIER, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextFocusedIndexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: nextFocusedIndexPath) as? ForeCastCollectionViewCell {
//            cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
        if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath, let cell = collectionView.cellForItem(at: previouslyFocusedIndexPath) as? ForeCastCollectionViewCell {
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

