//
//  NYTimesAPITests.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import XCTest
@testable import NY_Times

final class NYTimesAPITests: XCTestCase {
    
    /// Tests that the URL is correctly constructed with the base URL, endpoint, and API key.
    func testGetURL() {
        let expectedURLString = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=yoYAAU4G3t2yekvbH03H58gX7deV4Oq6"
        
        let url = NYTimesAPI.getURL(for: NYTimesAPI.Endpoint.articlesList)
        
        XCTAssertEqual(url.absoluteString, expectedURLString, "The constructed URL should match the expected URL string.")
    }
}
