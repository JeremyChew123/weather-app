//
//  WelcomeView.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 16/10/25.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to WeatherMan!")
                .font(.title).bold()
            
            Text("Please share with us your current location to get your weather conditions")
                .padding()
        }
        .padding()
        .multilineTextAlignment(.center)
        
        LocationButton(.currentLocation) {
            locationManager.requestAuthorisation()
        }
        .symbolVariant(.fill)
        .cornerRadius(30)
        .foregroundStyle(.white)
    }
}

#Preview {
    WelcomeView()
}
