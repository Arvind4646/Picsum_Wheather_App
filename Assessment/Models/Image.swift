//
//  Images.swift
//  Assessment
//
//  Created by Arvind Rawat on 22/11/25.
//

import Foundation
import CoreLocation

struct Image: Identifiable, Decodable, Equatable {
    let id: Int
    let format: String
    let width: Int
    let height: Int
    let filename: String
    let author: String
    let author_url: String
    let post_url: String
    
    // Seeded geo: pseudo-random repeatable
    var coordinate: CLLocationCoordinate2D {
        let lat = Double(((id * 73) % 180) - 90)
        let lon = Double(((id * 41) % 360) - 180)
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
