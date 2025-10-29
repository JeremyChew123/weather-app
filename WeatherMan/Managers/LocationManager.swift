//
//  LocationManager.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 16/10/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading: Bool = false
    @Published var error: LocationError?
    
    //The manager for start/stop/ask permission
    let manager = CLLocationManager()
    
    //Assigning delegate object
    override init() {
        super.init()
        manager.delegate = self
    }
    
    var isAuthorized: Bool {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: return true
        default: return false
        }
    }
    
    var needsPermission: Bool { manager.authorizationStatus == .notDetermined }
    
    //To authorise location when app is in use and check if location services are enabled
    func requestAuthorisation() {
        guard CLLocationManager.locationServicesEnabled() else {
            error = .servicesDisabled
            return
        }
        manager.requestWhenInUseAuthorization()
    }
    
    //When user changes location services
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            isLoading = false
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            isLoading = false
            error = .permissionDenied
        case .authorizedAlways, .authorizedWhenInUse:
            requestLocation()
        @unknown default:
            isLoading = false
            break
        }
    }
    
    //One time request location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    //To receive location - called when Core Location has new data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            location = coordinate
        } else {
            error = .noCoord
        }
        isLoading = false
    }
    
    //Called when there is an error
    func locationManager(_ manager: CLLocationManager, didFailWithError err: Error) {
        error = .coreLocation(err)
        isLoading = false
    }
}

enum LocationError: LocalizedError, Identifiable {
    case servicesDisabled
    case permissionDenied
    case noCoord
    case coreLocation(Error)
    
    var id: String {
        switch self {
        case .servicesDisabled: return "servicesDisabled"
        case .permissionDenied: return "permissionDenied"
        case .noCoord:    return "noCoordinates"
        case .coreLocation(let err): return "coreLocation:\(err.localizedDescription)"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .servicesDisabled:
            return "Location services are disabled."
        case .permissionDenied:
            return "Permission to access location was denied - Please go to settings to enable."
        case .noCoord:
            return "No coordinates found."
        case .coreLocation:
            return "Failure to get location"
        }
    }
    
    var failureReason: String? {
        switch self {
            case .servicesDisabled:
            return "Location services are disabled."
        case .permissionDenied:
            return "Permission to access location was denied."
        case .noCoord:
            return "No coordinates found."
        case .coreLocation(let err):
            return "Error: \(err.localizedDescription)"
        }
    }
}


