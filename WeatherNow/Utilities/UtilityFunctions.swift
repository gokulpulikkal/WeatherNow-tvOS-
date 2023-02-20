//
//  UtilityFunctions.swift
//  WeatherNow
//
//  Created by Gokul P on 17/02/23.
//

import TVUIKit

func getTimeStringFromSec(seconds: Double, format: String = "E, h:mm a") -> String {
    let date = Date(timeIntervalSince1970: seconds)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func saveObjectToUserDefaults<T: Codable>(object: T, key: String) {
    do {
        let data = try JSONEncoder().encode(object)
        UserDefaults.standard.set(data, forKey: key)
    } catch let error {
        print("save failed \(error)")
    }
}

func getValueFromUserDefaults<T: Codable>(key: String) -> T? {
    do {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
        
    } catch let error {
        print("retrieving failed \(error)")
        return nil
    }
}

func isDayTime(time: Date) -> Bool {
    // Get the sunrise and sunset times for the assumed time zone
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: time)
    return hour >= 6 && hour < 18
}

