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

