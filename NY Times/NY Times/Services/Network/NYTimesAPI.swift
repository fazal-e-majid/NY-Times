//
//  NYTimesAPI.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import Foundation

struct NYTimesAPI {
    ///Base url of the New York Times Most Popular API
    static let baseURL = "https://api.nytimes.com/svc/mostpopular/v2"
    
    ///New York Times Developer API Key
    static let apiKey = "yoYAAU4G3t2yekvbH03H58gX7deV4Oq6"
    
    ///Creates and returns URL based on the available endpoints
    static func getURL(for endPoint: Endpoint) -> URL {
        guard var components = URLComponents(string: baseURL.appending(endPoint.rawValue))
        else { fatalError("Invalid URL") }
        
        components.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey)
        ]
        
        guard let url = components.url else {
            fatalError("Could not create URL from components")
        }
        
        return url
    }
    
    ///API endpoints
    enum Endpoint: String {
        case articlesList = "/mostviewed/all-sections/7.json"
    }
}
