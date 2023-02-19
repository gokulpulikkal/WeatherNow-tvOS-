//
//  LocationsResponseModel.swift
//  WeatherNow
//
//  Created by Gokul P on 19/02/23.
//

import Foundation

struct LocationsResponseModel: Decodable {
    let locationsList: [LocationModel]?
    let links: [LinkModel]?
    let metadata: MetadataModel?
    let message: String?

    //  This is to change the key that we are getting from the response to match with the model fields
    private enum CodingKeys: String, CodingKey {
        case locationsList = "data"
        case links
        case metadata
        case message
    }
}

struct LocationModel: Decodable {
    let id: Double?
    let wikiDataId: String?
    let name: String?
    let country: String?
    let latitude: Double?
    let longitude: Double?
}

struct LinkModel: Decodable {
    let rel: String?
    let href: String?
}

struct MetadataModel: Decodable {
    let currentOffset: Int?
    let totalCount: Int?
}
