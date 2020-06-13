//
//  WeatherViewModel.swift
//  weather
//
//  Created by wtao on 5/27/20.
//  Copyright © 2020 wtao. All rights reserved.
//

import Foundation

struct CityWeather: Identifiable{
    let id: Int
    let name: String
    let temp: String
    let icon: String
}

class WeatherViewModel: ObservableObject{
    @Published var weatherItems = [CityWeather]()
    
    let cityNames = ["san jose", "san francisco", "sacramento"]
    
    func loadModel() {
        var i = 0
        
        for city in cityNames {
            WeatherModel.getTemperature(city) { item in
                self.weatherItems.append(CityWeather(id: i, name: city, temp: String(format: "%.2f℃", item.the_temp), icon: item.weather_state_abbr))
                i = i + 1
            }
        }
    }
}
