//
//  OpenWeatherMapController.swift
//  WeatherApp
//
//  Created by Abhishek Kumar on 30/06/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import SwiftyJSON

class OpenWeatherMapService: WebService {
    
    func fetchWeatherData(for city: String, completionHandler: @escaping (String?, WebServiceError?) -> Void) {
        // https://community-open-weather-map.p.rapidapi.com/weather
        let headers = [
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
            "x-rapidapi-key": "8c6e037525msh7c19ec1afc449f2p1d08f5jsn688a051a7532"
        ]
        
        let endpoint = "https://community-open-weather-map.p.rapidapi.com/find?q=\(city)&units=imperial"
        guard let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let endpointURL = URL(string: safeURLString) else {
                completionHandler(nil, WebServiceError.invaildURL(endpoint))
                return
        }
        
        var request = URLRequest(url: endpointURL)
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, WebServiceError.forwarded(error!))
                return
            }
            
            guard let responseData = data else {
                completionHandler(nil, WebServiceError.invalidPayload(endpointURL))
                return
            }
            
            let json = try? JSON(data: responseData)
            print("json[list][main] = \(json!["list"][0]["main"]["feels_like"])")
            if let feelsLikeTemp = json!["list"][0]["main"]["feels_like"].double {
                completionHandler("\(feelsLikeTemp)", nil)
            }
        }
        dataTask.resume()
    }
}
