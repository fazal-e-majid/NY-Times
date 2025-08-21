//
//  MockNetworkSession.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import Foundation
import Combine
@testable import NY_Times

// Mock NetworkSession for testing
class MockNetworkSession: NetworkSession {
    var result: Result<Data, NetworkError>?
    var request: URLRequest?
    
    func publisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, NetworkError> {
        self.request = request
        
        guard let result = result else {
            return Fail(error: NetworkError.networkError(URLError(.notConnectedToInternet)))
                .eraseToAnyPublisher()
        }
        
        switch result {
        case .success(let data):
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return Just(decodedObject)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: NetworkError.decodingError(error))
                    .eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

