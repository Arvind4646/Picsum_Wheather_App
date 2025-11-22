//
//  weather.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation
struct Weather: Decodable, Equatable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let current_units: CurrentUnits
    let current: Current
}

struct CurrentUnits: Decodable, Equatable {
    let time : String
    let interval : String
    let temperature_2m: String
    let relative_humidity_2m: String
    let wind_speed_10m: String
}

struct Current: Decodable, Equatable {
    let time: String
    let interval: Int
    let temperature_2m: Double
    let relative_humidity_2m: Int
    let wind_speed_10m: Double
}
