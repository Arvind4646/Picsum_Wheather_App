//
//  WeatherService.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation
import CoreLocation

final class WeatherService: WeatherServiceProtocol {
    func fetchWeather(for coordinate: CLLocationCoordinate2D) async throws -> Weather {
        let urlStr = "https://api.open-meteo.com/v1/forecast?latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)&current=temperature_2m,relative_humidity_2m,wind_speed_10m"
        guard let url = URL(string: urlStr) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Weather.self, from: data)

    }
}
