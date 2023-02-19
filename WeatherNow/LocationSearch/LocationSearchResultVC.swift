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
            resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
            print(response)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}

extension LocationSearchResultVC: UITableViewDelegate {
    
}
