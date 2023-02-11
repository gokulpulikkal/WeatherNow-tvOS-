//
//  NetworkManagerSupporter.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

/// Error types from the network requests
enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}

enum HTTPMethod: String {
    case GET
    case POST
}
