//
//  HomeVCModel.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

func getCurrentWeather(lon:Double, lat: Double, onCompletion: @escaping (BaseWeatherModel)->()) {
    let apiKey = Configuration.getAPIKey(forKey: APIKey.OpenWeatherKey) ?? ""
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=12.9767936&lon=77.590082&appid=\(apiKey)&units=metric"
    _ = ServiceManager.shared.callService(urlString: url, method: .GET) { (response: BaseWeatherModel) in
        onCompletion(response)
    } fail: { error in
        print(error)
    }
}


func getForecastData(lon:Double, lat: Double, onCompletion: @escaping (ForeCastResponse)->()) {
    let apiKey = Configuration.getAPIKey(forKey: APIKey.OpenWeatherKey) ?? ""
    let url = "https://api.openweathermap.org/data/2.5/forecast?lat=12.9767936&lon=77.590082&appid=\(apiKey)&units=metric"
    _ = ServiceManager.shared.callService(urlString: url, method: .GET) { (response: ForeCastResponse) in
        onCompletion(response)
    } fail: { error in
        print(error)
    }
}
