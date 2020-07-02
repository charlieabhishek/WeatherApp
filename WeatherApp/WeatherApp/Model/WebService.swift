//
//  WebServiceController.swift
//  WeatherApp
//
//  Created by Abhishek Kumar on 30/06/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

public enum WebServiceError: Error {
    case invaildURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

public protocol WebService {
    func fetchWeatherData(for city: String,
                          completionHandler: @escaping (String?, WebServiceError?) -> Void)
}
