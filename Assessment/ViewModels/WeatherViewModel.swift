//
//  WeatherViewModel.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: Weather? = nil
    @Published var isLoading = false
    @Published var error: String? = nil
    let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for coordinate: CLLocationCoordinate2D) async {
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            weather = try await weatherService.fetchWeather(for: coordinate)
        } catch {
            self.error = error.localizedDescription
        }
    }
}
