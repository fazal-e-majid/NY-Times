//
//  APIError.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case unauthorize
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .unauthorize:
            return "You don’t have permission to access this resource."
        case .invalidResponse:
            return "The response is invalid."
        case .decodingError(let error):
            return "Failed to decode the data: \(error.localizedDescription)"
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        }
    }
}
