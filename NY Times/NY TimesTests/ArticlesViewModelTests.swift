//
//  ArticlesViewModelTests.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import XCTest
import Combine
@testable import NY_Times

final class ArticlesViewModelTests: XCTestCase {
    var viewModel: ArticlesViewModel!
    var mockService: MockArticleService!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        // before each test
        mockService = MockArticleService()
        viewModel = ArticlesViewModel(articleService: mockService)
    }
    
    override func tearDown() {
        // after each test
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    /// Tests that the view model correctly fetches articles and sets the view state to .loaded.
    func testFetchArticlesSuccess() {
        let article1 = ArticleData(id: 1, url: URL(string: "https://example.com/a1")!, publishedDate: "2023-01-01", title: "Article 1", abstract: "Abstract 1", source: "Source 1", section: "Section 1", byline: "Byline 1")
        let article2 = ArticleData(id: 2, url: URL(string: "https://example.com/a2")!, publishedDate: "2023-01-02", title: "Article 2", abstract: "Abstract 2", source: "Source 2", section: "Section 2", byline: "Byline 2")
        let articleResponse = ArticleResponse(results: [article1, article2])
        mockService.result = .success(articleResponse)
        
        // Use an expectation to wait for the asynchronous result
        let expectation = self.expectation(description: "ViewModel should load articles successfully")
        
        // Subscribe to the articles state to check for changes
        viewModel.$articles
            .dropFirst() // for initial .loading state
            .sink { state in
                if case .loaded(let articles) = state {
                    XCTAssertEqual(articles.count, 2, "The view model should load 2 articles.")
                    XCTAssertEqual(articles.first?.title, "Article 1", "The first article's title should be correct.")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchArticles()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Tests that the view model correctly handles a network failure and sets the view state to .error.
    func testFetchArticlesFailure() {
        mockService.result = .failure(NetworkError.networkError(URLError(.notConnectedToInternet)))
        
        let expectation = self.expectation(description: "ViewModel should fail to load articles")
        
        viewModel.$articles
            .dropFirst()
            .sink { state in
                if case .error(let error) = state {
                    guard let networkError = error as? NetworkError else {
                        XCTFail("The error should be a NetworkError.")
                        return
                    }
                    
                    if case let NetworkError.networkError(underlyingError) = networkError {
                        // URLError code is more reliable test
                        XCTAssertEqual((underlyingError as? URLError)?.code, .notConnectedToInternet, "The underlying error should be a .notConnectedToInternet error.")
                        expectation.fulfill()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchArticles()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Tests that the view model correctly handles a decoding failure.
    func testFetchArticlesDecodingFailure() {
        mockService.result = .failure(NetworkError.decodingError(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Invalid JSON"))))
        
        let expectation = self.expectation(description: "ViewModel should fail due to decoding error")
        
        viewModel.$articles
            .dropFirst()
            .sink { state in
                if case .error(let error) = state {
                    // Make sure the error is the correct type
                    guard let networkError = error as? NetworkError else {
                        XCTFail("The error should be a NetworkError.")
                        return
                    }
                    
                    if case .decodingError(_) = networkError {
                        expectation.fulfill()
                    } else {
                        XCTFail("The error should be a decoding error.")
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchArticles()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /// Tests that the fetchArticles() method sets the state to .loading.
    func testFetchArticlesSetsStateToLoading() {
        XCTAssertEqual(String(describing: viewModel.articles), "loading", "The initial state should be .loading.")
        
        viewModel.fetchArticles()
        
        XCTAssertEqual(String(describing: viewModel.articles), "loading", "The state should be .loading after calling fetchArticles.")
    }
}

