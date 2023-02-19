//
//  Configurations.swift
//  WeatherNow
//
//  Created by Gokul P on 19/02/23.
//

import Foundation

class Configuration {
    static var keys: [String: String] = {
        guard let path = Bundle.main.path(forResource: "Configs", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path),
            let keys = config["API_KEYS"] as? [String: String] else {
            print("Couldn't find API keys plist")
            return [String: String]()
            
        }
        return keys
    }()

    static func getAPIKey(forKey key: APIKey) -> String? {
        return keys[key.rawValue]
    }
}

enum APIKey: String {
    case OpenWeatherKey = "OpenWeatherKey"
    case locationsAPIKey = "locationsAPIKey"
}
