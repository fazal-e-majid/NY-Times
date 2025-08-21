//
//  MockArticleService.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import Foundation
import Combine
@testable import NY_Times

// A mock service to control the network response for the ViewModel tests
class MockArticleService: ArticleService {
    var result: Result<ArticleResponse, NetworkError>?
    
    func getArticles() -> AnyPublisher<ArticleResponse, NetworkError> {
        guard let result = result else {
            return Fail(error: NetworkError.networkError(URLError(.notConnectedToInternet))).eraseToAnyPublisher()
        }
        return result.publisher
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

