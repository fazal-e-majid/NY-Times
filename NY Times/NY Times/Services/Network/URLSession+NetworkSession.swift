//
//  URLSession+Ext.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import Foundation
import Combine

protocol NetworkSession: AnyObject {
    func publisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, NetworkError>
}

extension URLSession: NetworkSession {
    /// This function handles the network call, validates the response, and decodes the
    /// received data into a specified Decodable type.
    func publisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, NetworkError> {
        
        return self.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                if httpResponse.statusCode == 401 { throw NetworkError.unauthorize }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.networkError(URLError(.badServerResponse))
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

