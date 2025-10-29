//
//  ControllerView.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 19/10/25.
//

import SwiftUI
import CoreLocation

struct ControllerView: View {
    
    @StateObject var locationManager = LocationManager()
    private let weatherManager = WeatherManager()
    @State var weather: WeatherInfo?
    @State var isShowingAlert: Bool = false
    @State var weatherError: WeatherError = .decodingFailed
    
    var body: some View {
        
        let content = Group {
            switch(locationManager.location, locationManager.isLoading, weather) {
            case (_, true, _):
                //Get the location
                ProgressView("Getting your location")
            case (nil, false, _):
                WelcomeView()
                    .environmentObject(locationManager)
            case (_, _, let weather?):
                WeatherView(weather: weather)
            default:
                ProgressView("Loading Weather Data")
            }
        }
        .task(id: locationManager.location) {
            guard let location = locationManager.location else { return }
            do {
                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
            } catch WeatherError.invalidResponse {
                weatherError = .invalidResponse
                isShowingAlert = true
            } catch WeatherError.invalidURL {
                weatherError = .invalidURL
                isShowingAlert = true
            } catch WeatherError.decodingFailed {
                isShowingAlert = true
            } catch {
                print("unknown error")
            }
        }
        
        content
            // Weather alert
            .alert(isPresented: $isShowingAlert, error: weatherError) { _ in
                Button("OK") {}
            } message: { err in
                Text("Error: \(err.failureReason)")
            }
            // Location alert
            .alert(item: $locationManager.error) { error in
                Alert(
                    title: Text(error.errorDescription ?? "Error"),
                    message: Text(error.failureReason ?? ""),
                    dismissButton: .default(Text("OK")) {
                        locationManager.error = nil
                    }
                )
            }
    }
        
//        VStack {
//            //do i have a location?
//           if let location = locationManager.location {
//               //if have location, then check if have weather
//               if let weather = weather {
//                   //if have weather then launch weatherview
//                   WeatherView(weather: weather)
//               } else {
//                   //if no weather, then call weather
//                   ProgressView()
//                       .task {
//                       do {
//                           weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
//                       } catch InfoError.invalidResponse {
//                           weatherError = .invalidResponse
//                           isShowingAlert = true
//                       } catch InfoError.invalidURL {
//                           weatherError = .invalidURL
//                           isShowingAlert = true
//                       } catch InfoError.decodingFailed {
//                           isShowingAlert = true
//                       } catch {
//                           break
//                       }
//                   }
//               }
//            }
//            else {
//                if locationManager.isLoading {
//                    ProgressView()
//                } else {
//                    WelcomeView()
//                        .environmentObject(locationManager)
//                }
//            }
//        }
//        .alert(isPresented: $isShowingAlert, error: weatherError) { error in
//            
//        } message: { error in
//            Text("Error: \(error.failureReason)")
//        }
//    }
}

#Preview {
    ControllerView()
}
