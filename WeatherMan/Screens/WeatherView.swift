//
//  WeatherView.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 15/10/25.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    
                    Text("Current Location")
                        .font(.title.bold())
                        .lineLimit(1)
                    
                    Text("Today: \(Date.now, format: .dateTime.month().day().hour().minute())")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "sun.max")
                            .font(.system(size: 30))
                        
                        Text("Clear")
                    }
                    
                    Spacer()
                    
                    Text("33°")
                        .font(.system(size: 80)).bold()
                }
                .padding()
                
                AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2021/12/20/04/04/buildings-6882271_1280.png")) {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                }
                .padding()
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Current Weather")
                        .font(.title2.bold())
                        .padding(.top)
                        
                    VStack {
                        HStack {
                            Image(systemName: "thermometer")
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(Color(hue: 1, saturation: 0, brightness: 0.888))
                                .cornerRadius(50)
                                .padding()
                            
                            Text("L: 23°      H: 34°")
                                .font(.title3.bold())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color(hue: 0.386, saturation: 0.913, brightness: 0.372))
                .background(.white)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
                
                    
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.386, saturation: 0.913, brightness: 0.372))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeatherView()
}
