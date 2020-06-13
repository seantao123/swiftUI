//
//  WeatherModel.swift
//  weather
//
//  Created by wtao on 5/27/20.
//  Copyright © 2020 wtao. All rights reserved.
//

import Foundation

struct Location: Codable {
    let title: String
    let woeid: Int
}

struct WeatherItem: Codable {
    let the_temp: Double
    let weather_state_abbr: String
}

struct Weather: Codable {
    let consolidated_weather: [WeatherItem]
}

class WeatherModel {
    static func getTemperature(_ cityName: String, _ onComplete: @escaping (WeatherItem) -> Void) {
        guard let url = URL(string: "https://whaleweather.herokuapp.com/api/location/search/?query=" + cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) else { return }
        URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let data = data, let locations = try? JSONDecoder().decode([Location].self, from: data) else { return }
            guard locations.count > 0, let url = URL(string: "https://whaleweather.herokuapp.com/api/location/" + String(locations[0].woeid)) else { return }
            URLSession.shared.dataTask(with: url) {data, _, _ in
                guard let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data) else { return }
                DispatchQueue.main.async {
                    onComplete(weather.consolidated_weather[0])
                }
            }.resume()
        }.resume()
    }
}
