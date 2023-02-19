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
    
    private var timer: Timer?
    var menuPressRecognizer: UITapGestureRecognizer?
    
    let LOCATION_USER_DEFAULTS_KEY = "location"
    var canExitAppIfNoLocation = false
    var location: LocationModel? {
        didSet {
            self.locationLabel.text = location?.name ?? ""
        }
    }
    
    var weatherList: [BaseWeatherModel] = []
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .RefreshDataNotification, object: nil)
        showTimeLabel()
        setUpCollectionView()
        UserDefaults.standard.removeObject(forKey: LOCATION_USER_DEFAULTS_KEY)
        setUpHomeViewData()
        setUpMenuPressHandler()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        print("deiniting HomeVC")
        NotificationCenter.default.removeObserver(self, name: .RefreshDataNotification, object: nil)
    }
    
    private func setUpHomeViewData() {
        if let location: LocationModel = getValueFromUserDefaults(key: LOCATION_USER_DEFAULTS_KEY) {
            makeWeatherAPICalls(location: location)
            self.location = location
        } else {
            showOptionsAlertVC(title: "Hi Welcome to WeatherNow",
                               message: "Get the latest update on weather, Just select the location you need, We will provide you the accurate result",
                               firstOptionString: "Search The city")
        }
    }
    
    //MARK: - Ui Handling
    
    // Refreshes the data for the UI
    @objc func refreshData() {
        setUpHomeViewData()
    }
    
    private func setUpCollectionView() {
        view.addSubview(forecastCollectionView)
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor),
            forecastCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            forecastCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 50
        layout.itemSize = CGSize(width: 480, height: 250)
        return layout
    }
    
    private func showTimeLabel() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            let formatter = DateFormatter()
            formatter.dateFormat = "E, MMMM d h:mma"
            self?.dateTimeLabel.text = formatter.string(from: Date())
        }
    }
    
    private func showOptionsAlertVC(title: String = "Hey There",
                                    message: String = "What do you wanna do now? Select one option",
                                    firstOptionString: String = "Change Location",
                                    secondOptionString: String="Exit!") {
        let title = title
        let message = message
        let locationChangeButtonTitle = firstOptionString
        let backButtonTitle = secondOptionString
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create the actions.
        let changeLocationAction = UIAlertAction(title: locationChangeButtonTitle, style: .default) { [weak self] _ in
            self?.onSelectingLocationChange()
        }
        
        let backAction = UIAlertAction(title: backButtonTitle, style: .cancel) { [weak self] _ in
            self?.onSelectingBackButton()
        }
        
        // Add the actions.
        alertController.addAction(changeLocationAction)
        alertController.addAction(backAction)
        self.canExitAppIfNoLocation = true
        present(alertController, animated: true, completion: nil)
    }
    
    private func showLocationSelectorView() {
        
        let searchResultsController = LocationSearchResultVC()
        searchResultsController.delegate = self
        /*
            Create a UISearchController, passing the `searchResultsController` to
            use to display search results.
        */
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.searchBar.placeholder = NSLocalizedString("Enter keyword (e.g. iceland)", comment: "")
        
        // Contain the `UISearchController` in a `UISearchContainerViewController`.
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = NSLocalizedString("Search", comment: "")
        
        self.navigationController?.pushViewController(searchContainer, animated: true)
        
        // Sets the focus to the SearchControllerView
        updateFocusIfNeeded()
        setNeedsFocusUpdate()
        
    }
    
   //MARK: - API calls
    func makeWeatherAPICalls(location: LocationModel) {
        getCurrentWeather(lon: location.longitude ?? 0, lat: location.latitude ?? 0) { [weak self] currentWeather in
            guard let self = self else { return }
            self.temperatureLabel.text = "\(Int(currentWeather.main?.temp ?? 0))°C"
            self.weatherStatusLabel.text = currentWeather.weather?.first?.description ?? ""
            self.feelsLikeLabel.text = "\(Int(currentWeather.main?.feelsLike ?? 0))°C"
            self.highestTemperatureLabel.text = "\(Int(currentWeather.main?.tempMax ?? 0))°C"
            self.lowestTemperatureLabel.text = "\(Int(currentWeather.main?.tempMin ?? 0))°C"
            self.weatherStatusImageView.image = UIImage(named: "\(currentWeather.weather?.first?.main ?? "")")
        }
        
        getForecastData(lon: location.longitude ?? 0, lat: location.latitude ?? 0) { [weak self] forecastList in
            guard let self = self else { return }
            guard let weatherList = forecastList.weatherList else { return }
            
            self.weatherList = weatherList
            self.forecastCollectionView.reloadData()
            
        }
    }
    
    //MARK: - Button press handling
    
    func setUpMenuPressHandler() {
        menuPressRecognizer = UITapGestureRecognizer()
        menuPressRecognizer!.addTarget(self, action: #selector(onMenuPressOnRemote))
        menuPressRecognizer!.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        self.view.addGestureRecognizer(menuPressRecognizer!)
    }
    
    @objc func onMenuPressOnRemote() {
        showOptionsAlertVC()
    }
    
    private func onSelectingLocationChange() {
        showLocationSelectorView()
    }
    
    private func onSelectingBackButton() {
        suspendApp()
    }
    
    private func checkLocationAvailabilityAndShowMsg() {
        if location == nil {
            // show info message
            print("showing some message")
        }
    }
    
    private func suspendApp() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForeCastCollectionViewCell.CELL_IDENTIFIER, for: indexPath)
        if indexPath.item < self.weatherList.count, let forecastCell = cell as? ForeCastCollectionViewCell {
            let forecastDataAtIndex = self.weatherList[indexPath.item]
            forecastCell.cellData = forecastDataAtIndex
        }
        return cell
    }
}

extension HomeViewController: SearchResultDelegateProtocol {
    func didSelectSearchResult(location: LocationModel) {
        // removing the searchVC
        self.navigationController?.popViewController(animated: true)
        
        // save the location details on persistent storage
        saveObjectToUserDefaults(object: location, key: LOCATION_USER_DEFAULTS_KEY)
       
        // reload the locations data and
        self.location = location
        makeWeatherAPICalls(location: location)
    }
}

