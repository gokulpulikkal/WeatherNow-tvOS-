//
//  HomeVCModel.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

func getForeCastData() {
    
}

func getCurrentWeather(lon:Double, lat: Double, onCompletion: @escaping (CurrentWeatherModel)->()) {
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=12.9767936&lon=77.590082&appid=93fc112871e2f24aba37f420bf035e68&units=metric"
    ServiceManager.shared.callService(urlString: url, method: .GET) { (response: CurrentWeatherModel) in
        onCompletion(response)
    } fail: { error in
        print(error)
    }
}


