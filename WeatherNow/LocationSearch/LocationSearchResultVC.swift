//
//  LocationSearchResultVC.swift
//  WeatherNow
//
//  Created by Gokul P on 19/02/23.
//

import UIKit

class LocationSearchResultVC: UIViewController {
    
    var searchTask: URLSessionDataTask?
    var searchString = "" {
        didSet {
            guard searchString != oldValue else { return }
            if !searchString.isEmpty, searchString.count >= 3 {
                searchForCity(searchString)
            }
        }
    }
    
    weak var delegate: SearchResultDelegateProtocol?
    
    let resultTableView = UITableView()
    var cityList: [LocationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
//    MARK: - UI handlings
    private func setUpTableView() {
        view.addSubview(resultTableView)
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            resultTableView.widthAnchor.constraint(equalToConstant: 700),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        resultTableView.register(LocationResultTableViewCell.self, forCellReuseIdentifier: LocationResultTableViewCell.CELL_IDENTIFIER)
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
//    MARK: - API calls
    private func searchForCity(_ searchString: String) {
        searchTask?.cancel()
        let apiKey = Configuration.getAPIKey(forKey: APIKey.locationsAPIKey) ?? ""
        let header = ["X-RapidAPI-Key": apiKey]
        let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=" + searchString
        searchTask = ServiceManager.shared.callService(urlString: url, method: .GET, headers: header) { [weak self] (response: LocationsResponseModel) in
            
            guard response.locationsList?.count ?? 0 > 0 else { return }
            self?.cityList = response.locationsList!
            self?.resultTableView.reloadData()
            
        } fail: { error in
            print(error)
        }
    }

}

extension LocationSearchResultVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text ?? ""
    }
}

extension LocationSearchResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationResultTableViewCell.CELL_IDENTIFIER, for: indexPath)
        
        if let cell = cell as? LocationResultTableViewCell {
            cell.cityNameLabel.text = cityList[indexPath.item].name ?? ""
        }
        return cell
    }
}

extension LocationSearchResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSearchResult(location: cityList[indexPath.item])
    }
}
