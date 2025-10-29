//
//  WeatherView.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 15/10/25.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: WeatherInfo
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading) {
                    Text(weather.name)
                        .font(.title.bold())
                        .lineLimit(1)
                    
                    Text("Today: \(Date.now, format: .dateTime.month().day().hour().minute())")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 30))
                            
                            Text("\(weather.weather[0].main) and Feels Like:")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text("\(weather.main.feelsLike.roundDouble())°")
                            .font(.system(size: 80)).bold()
                    }
                    
                    Spacer()
                        .frame(height: 100)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2021/12/20/04/04/buildings-6882271_1280.png")) {image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Weather Now:")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Current Temp", value: "\(weather.main.temp.roundDouble()+"°")")
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: "\(weather.main.tempMax.roundDouble()+"°")")
                    }
                
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind Speed", value: "\(weather.wind.speed.roundDouble()+"m/s")")
                        Spacer ()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble()+"%")")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.horizontal, 15)
                .padding(.bottom, 20)
                .foregroundStyle(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.386, saturation: 0.913, brightness: 0.372))
        .preferredColorScheme(.dark)
    }
}
