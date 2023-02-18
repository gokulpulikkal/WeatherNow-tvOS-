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
            if !searchString.isEmpty {
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func searchForCity() {
        searchTask?.cancel()
        
//        searchTask = ServiceManager.shared.callService(urlString: url, method: .GET) { (response: ForeCastResponse) in
//            onCompletion(response)
//        } fail: { error in
//            print(error)
//        }
    }

}

extension LocationSearchResultVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text ?? ""
    }
    
    
}
