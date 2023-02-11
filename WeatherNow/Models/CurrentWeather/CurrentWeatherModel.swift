//
//  CurrentWeatherModel.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let main: BasicWeatherDetails?
    let weather: [Weather]?
}

struct BasicWeatherDetails: Decodable {
    let temp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Float?
    let humidity: Float?
    
//    This is to change the key that we are getting from the response to match with the model fields
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
