//
//  ForeCastResponse.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

struct ForeCastResponse: Decodable {
    let weatherList: [BaseWeatherModel]?
    //This is to change the key that we are getting from the response to match with the model fields
    private enum CodingKeys: String, CodingKey {
        case weatherList = "list"
    }
}
