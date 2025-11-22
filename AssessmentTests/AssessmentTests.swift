//
//  AssessmentTests.swift
//  AssessmentTests
//
//  Created by Arvind Rawat on 22/11/25.
//

import XCTest
import CoreLocation
@testable import Assessment

final class ImageServiceTests: XCTestCase {
    func testDecodePicsumImage() throws {
        let json = """
        [{
            "id": 0,
            "format": "jpg",
            "width": 500,
            "height": 500,
            "filename": "test.jpg",
            "author": "test",
            "author_url": "https://example.com",
            "post_url": "https://example.com/post",
        }]
        """.data(using: .utf8)!
        
        let images = try JSONDecoder().decode([Image].self, from: json)
        
        XCTAssertEqual(images.first?.id, 0)
        XCTAssertEqual(images.first?.format, "jpg")
        XCTAssertEqual(images.first?.width, 500)
        XCTAssertEqual(images.first?.height, 500, "This test case passed")
        XCTAssertEqual(images.first?.filename, "test.jpg")
        XCTAssertEqual(images.first?.author, "test")
        XCTAssertEqual(images.first?.author_url, "https://example.com")
        XCTAssertEqual(images.first?.post_url, "https://example.com/post")
    }
}

final class PaginationTests: XCTestCase {
    class MockService: ImageServiceProtocol {
        
        func fetchImages() async throws -> [Image] {
            (0..<200).map { Image(id: $0, format: "", width: 1, height: 1, filename: "", author: "A", author_url: "", post_url: "")
            }
        }
        func imageURL(for id: Int) -> URL? { URL(string: "https://example.com")! }
    }
    
    func testPaginationAppends() async {
        let vm = await ImageFeedViewModel(imageService: MockService())
        await vm.initialFetch()
        await vm.loadMoreImages()
        await vm.loadMoreImages()
        await vm.loadMoreImages()
        let allImagesCount = await MainActor.run {
            vm.allImages.count
        }
        let imagesCount = await MainActor.run {
            vm.images.count
        }
        XCTAssertEqual(allImagesCount, 200)
        XCTAssertEqual(imagesCount, 120)
    }

}

final class WeatherFetchTests: XCTestCase {
    class MockWeather: WeatherServiceProtocol {
        func fetchWeather(for coordinate: CLLocationCoordinate2D) async throws -> Weather {
            Weather(
                latitude: 1,
                longitude: 1,
                generationtime_ms: 0,
                utc_offset_seconds: 0,
                timezone: "GMT",
                timezone_abbreviation: "GMT",
                elevation: 0,
                current_units: CurrentUnits(
                    time: "iso8601",
                    interval: "seconds",
                    temperature_2m: "°C",
                    relative_humidity_2m: "%",
                    wind_speed_10m: "km/h"),
                current: Current(
                    time: "2025-11-22T06:45",
                    interval: 900,
                    temperature_2m: 23,
                    relative_humidity_2m: 50,
                    wind_speed_10m: 1)
            )
        }
    }

    func testWeatherFetching() async {
        let vm = await WeatherViewModel(weatherService: MockWeather())
        await vm.fetchWeather(for: .init(latitude: 1, longitude: 1))
        
        let temperature = await MainActor.run {
            vm.weather?.current.temperature_2m
        }
        let humidity = await MainActor.run {
            vm.weather?.current.relative_humidity_2m
        }
        let windSpeed = await MainActor.run {
            vm.weather?.current.wind_speed_10m
        }
        let timezone = await MainActor.run {
            vm.weather?.timezone
        }

        XCTAssertEqual(temperature, 23)
        XCTAssertEqual(humidity, 50)
        XCTAssertEqual(windSpeed, 1)
        XCTAssertEqual(timezone, "GMT")
    }
}

