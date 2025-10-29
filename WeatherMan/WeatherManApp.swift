//
//  WeatherManApp.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 15/10/25.
//

import SwiftUI

@main
struct WeatherManApp: App {
    
    @StateObject private var locationManager = LocationManager()
//    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ControllerView()
                .environmentObject(locationManager)
        }
//        .onChange(of: scenePhase) {
//            if scenePhase == .active, locationManager.isAuthorized {
//                // Safe to call every time app enters foreground / launches
//                locationManager.requestLocation()       // get a fresh one-shot fix
//            }
//        }
    }
}
