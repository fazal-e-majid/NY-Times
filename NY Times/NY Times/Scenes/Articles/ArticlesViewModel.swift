//
//  ArticlesViewModel.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import Foundation
import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
    @Published private(set) var articles: ViewState<[ArticleData]> = .loading
    
    let articleService: ArticleService
    var cancellables = Set<AnyCancellable>()
    
    init(articleService: ArticleService = NYArticleService()) {
        self.articleService = articleService
    }
    
    func fetchArticles() {
        withAnimation {
            self.articles = .loading
        }
        
        self.articleService.getArticles()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let networkError):
                    withAnimation {
                        self.articles = .error(networkError)
                    }
                case .finished: break
                }
            } receiveValue: { response in
                withAnimation {
                    self.articles = .loaded(response.results)
                }
            }
            .store(in: &self.cancellables)
    }
    
    func refreshArticles() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.fetchArticles()
        }
    }
}
