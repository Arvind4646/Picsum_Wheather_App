//
//  WeatherServiceProtocol.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func fetchWeather(for coordinate: CLLocationCoordinate2D) async throws -> Weather
}
