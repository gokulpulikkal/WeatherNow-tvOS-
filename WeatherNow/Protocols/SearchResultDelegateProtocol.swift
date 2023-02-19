//
//  SearchResultDelegateProtocol.swift
//  WeatherNow
//
//  Created by Gokul P on 19/02/23.
//

import Foundation

protocol SearchResultDelegateProtocol: AnyObject {
    
    func didSelectSearchResult(location: LocationModel)
}
