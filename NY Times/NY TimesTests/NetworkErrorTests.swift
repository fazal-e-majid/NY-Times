//
//  NetworkErrorTests.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import XCTest
@testable import NY_Times

final class NetworkErrorTests: XCTestCase {
    /// Tests the localized description for the invalidURL case.
    func testInvalidURLErrorDescription() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(error.errorDescription, "The URL is invalid.")
    }
    
    /// Tests the localized description for the unauthorize case.
    func testUnauthorizeErrorDescription() {
        let error = NetworkError.unauthorize
        XCTAssertEqual(error.errorDescription, "You don’t have permission to access this resource.")
    }
    
    /// Tests the localized description for the invalidResponse case.
    func testInvalidResponseErrorDescription() {
        let error = NetworkError.invalidResponse
        XCTAssertEqual(error.errorDescription, "The response is invalid.")
    }
    
    /// Tests the localized description for the decodingError case.
    func testDecodingErrorDescription() {
        let underlyingError = NSError(domain: "TestDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Test decoding error"])
        let error = NetworkError.decodingError(underlyingError)
        XCTAssertEqual(error.errorDescription, "Failed to decode the data: Test decoding error")
    }
    
    /// Tests the localized description for the networkError case.
    func testNetworkErrorDescription() {
        let underlyingError = NSError(domain: "TestDomain", code: 456, userInfo: [NSLocalizedDescriptionKey: "Test network error"])
        let error = NetworkError.networkError(underlyingError)
        XCTAssertEqual(error.errorDescription, "A network error occurred: Test network error")
    }
}
