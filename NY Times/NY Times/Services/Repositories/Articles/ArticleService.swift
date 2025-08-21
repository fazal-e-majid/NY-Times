//
//  ArticlesRepository.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import Foundation
import Combine

protocol ArticleService {
    func getArticles() -> AnyPublisher<ArticleResponse, NetworkError>
}

class NYArticleService: ArticleService {
    func getArticles() -> AnyPublisher<ArticleResponse, NetworkError> {
        var request = URLRequest(url: NYTimesAPI.getURL(for: .articlesList))
        request.httpMethod = "GET"
        
        return URLSession.shared.publisher(for: request)
    }
}
