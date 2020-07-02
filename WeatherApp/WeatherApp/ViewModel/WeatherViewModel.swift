//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhishek Kumar on 01/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class WeatherViewModel : ObservableObject {
    private let weatherService = OpenWeatherMapService()
    @Published var weatherInfo = ""
    
    func fetch(city: String){
        weatherService.fetchWeatherData(for: city) { (info, error) in
            guard error == nil,
                let weatherInfo = info else {
                    DispatchQueue.main.async {
                        self.weatherInfo = "Could not retrieve weather information for \(city)"
                    }
                    return
            }
            print("Inside fetch weather data completion handler.")
            DispatchQueue.main.async {
                self.weatherInfo = weatherInfo
            }
        }
    }
}
