//
//  LocationManager.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 16/10/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocationCoordinate2D?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    //The manager for start/stop/ask permission
    let manager = CLLocationManager()
    
    //Assigning delegate object
    override init() {
        super.init()
        manager.delegate = self
    }
    
    //To authorise location when app is in use and check if location services are enabled
    func requestAuthorisation() {
        guard CLLocationManager.locationServicesEnabled() else {
            errorMessage = "Location Services are disabled on your device"
            return
        }
        manager.requestWhenInUseAuthorization()
    }
    
    //When user changes location services
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .restricted, .denied:
            isLoading = false
            errorMessage = "Location Services is disabled on your device. Please go to settings to enable it"
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
        location = locations.first?.coordinate
        isLoading = false
    }
    
    //Called when there is an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to get location: \(error.localizedDescription)"
        isLoading = false
    }
}
