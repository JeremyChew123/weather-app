//
//  WeatherRow.swift
//  WeatherMan
//
//  Created by Jeremy Chew on 16/10/25.
//

import SwiftUI

struct WeatherRow: View {
    
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1, saturation: 0, brightness: 0.888))
                .cornerRadius(50)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .font(.title.bold())
            }
        }
    }
}

#Preview {
    WeatherRow(logo: "thermometer", name: "Feels Like", value: "24°C")
}
