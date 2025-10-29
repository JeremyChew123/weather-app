//
//  Model.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 17/10/25.
//

import Foundation
import CoreLocation

class WeatherManager {
    //Get the data from the API
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherInfo {
        let endPoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=02052cf796043b8d63506710fc6084fe&units=metric"
        
        guard let url = URL(string: endPoint) else { throw WeatherError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw WeatherError.invalidResponse }
        
        //decode the json
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherInfo.self, from: data)
        } catch {
            throw WeatherError.decodingFailed
        }
    }
}

struct WeatherInfo: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
    var name: String
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension WeatherInfo.MainResponse {
    var feelsLike: Double {return feels_like}
    var tempMin: Double {return temp_min}
    var tempMax: Double {return temp_max}
}

enum WeatherError: LocalizedError {
    case invalidResponse
    case decodingFailed
    case invalidURL
    case authRestricted
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "HTTP Code is not 200"
        case .decodingFailed:
            return "Decoding of JSON failed"
        case .invalidURL:
            return "Please recheck API link"
        case .authRestricted:
            return "Location Authorization is restriced"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed:
            return "Decoding failed"
        case .invalidURL:
            return "Invalid URL"
        case .authRestricted:
            return "Location Services is disabled on your device. Please go to settings to enable it"
        }
    }
}
