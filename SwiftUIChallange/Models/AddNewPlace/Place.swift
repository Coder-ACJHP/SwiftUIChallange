//
//  Place.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import Foundation
import MapKit

struct Place: Equatable, Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var adress: String = ""
    var iconName: String = "location.fill"
    var radius: Float = 50.0
    let latitude: Double = 41.0082
    let longitude: Double = 28.9784
    var arrivalNotification: Bool = false
    var leavingNotification: Bool = false
}

extension Place {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
