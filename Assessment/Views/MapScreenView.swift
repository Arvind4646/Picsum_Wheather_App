//
//  MapScreenView.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import SwiftUI
import GoogleMaps
import Kingfisher

struct MapScreenView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var imageViewModel: ImageFeedViewModel
    @State private var showingWeather = false

    var body: some View {
        ZStack {
            GoogleMapWrapper(vm: imageViewModel, weatherVM: weatherViewModel) { img in
                Task {
                    await weatherViewModel.fetchWeather(for: img.coordinate)
                    showingWeather = true
                }
            }
            .ignoresSafeArea(.container, edges: .top)

        }
        .sheet(isPresented: $showingWeather) {
            if let weather = weatherViewModel.weather {
                WeatherPopoverView(weather: weather)
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled(false)
            } else if weatherViewModel.isLoading {
                ProgressView()
                    .presentationDetents([.medium])
            } else if let error = weatherViewModel.error {
                Text("Error: \(error)")
                    .presentationDetents([.medium])
            } else {
                Text("No weather data")
                    .presentationDetents([.medium])
            }
        }
    }
}

struct GoogleMapWrapper: UIViewRepresentable {
    @ObservedObject var vm: ImageFeedViewModel
    @ObservedObject var weatherVM: WeatherViewModel
    var onMarkerTap: (Image) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.frame = .zero
        mapView.camera = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 2)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()
        
        for img in vm.images.prefix(50) {
            let marker = GMSMarker(position: img.coordinate)
            marker.userData = img
            if let url = URL(string: "https://picsum.photos/50/50?image=\(img.id)") {
                KingfisherManager.shared.retrieveImage(with: url) { result in
                    let image = (try? result.get())?.image
                    DispatchQueue.main.async {
                        marker.icon = image
                        marker.map = mapView
                    }
                }
            } else {
                marker.map = mapView
            }
        }
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        let parent: GoogleMapWrapper

        init(_ parent: GoogleMapWrapper) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let img = marker.userData as? Image {
                parent.onMarkerTap(img)
                return true
            }
            return false
        }
    }
}

struct WeatherPopoverView: View {
    let weather: Weather
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Temperature: \(weather.current.temperature_2m, specifier: "%.1f")\(weather.current_units.temperature_2m)")
            Text("Humidity: \(weather.current.relative_humidity_2m, specifier: "%.0f")\(weather.current_units.relative_humidity_2m)")
            Text("Wind Speed: \(weather.current.wind_speed_10m, specifier: "%.1f") \(weather.current_units.wind_speed_10m)")
        }
        .padding()
        .font(.title2)
    }
}

//#Preview {
//    MapScreenView(imageViewModel: ImageFeedViewModel())
//}
