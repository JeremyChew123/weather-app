//
//  View+Ext.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 15/10/25.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Double {
    func roundDouble() -> String { //string because you want the to display using Text in the View
        return String(format: "%.0f", self)
    }
}
