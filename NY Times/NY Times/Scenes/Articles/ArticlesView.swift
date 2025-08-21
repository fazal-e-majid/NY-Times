//
//  ContentView.swift
//  NY Times
//
//  Created by fmajid on 20/08/2025.
//

import SwiftUI

/// List of articles screen
struct ArticlesView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    /// for navigation between screens.
    @State private var path: [Route] = []
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.appBold(17),
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.appBold(34)
        ]
        navBarAppearance.backgroundColor = .white
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Rectangle()
                    .fill(Color.white.gradient)
                    .ignoresSafeArea()
                
                switch viewModel.articles {
                case .loading:
                    loadingView
                case .loaded(let articles):
                    contentView(articles: articles)
                case .error(let error):
                    failedView(error: error)
                }
            }
            .navigationTitle(
                Text("Articles")
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let articleData):
                    ArticleDetailView(articleData: articleData)
                        .tint(.black)
                }
            }
        }
        .tint(.black)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
    
    /// When the request for articles from the source is in progress
    @ViewBuilder
    private var loadingView: some View {
        VStack(spacing: 24) {
            ProgressView()
                .tint(.black)
                .scaleEffect(2)
            
            Text("Loading...")
                .font(.appRegular(17))
                .foregroundColor(.black)
        }
    }
    
    /// When articles loaded from the source.
    @ViewBuilder
    private func contentView(articles: [ArticleData]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(articles) { article in
                    ArticleItemView(article: article)
                        .onTapGesture {
                            path.append(.detail(articleData: article))
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .refreshable {
            viewModel.refreshArticles()
        }
    }
    
    /// When an error occurs to load the articles
    @ViewBuilder
    private func failedView(error: Error) -> some View {
        VStack(spacing: 0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
                .foregroundColor(.gray)
            
            Text("Failed")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Text(error.localizedDescription)
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.top, 2)
            
            Button {
                viewModel.fetchArticles()
            } label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Try Again".uppercased())
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                }
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
        .padding(.horizontal, 30)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 3)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    ArticlesView()
        .colorScheme(.light)
}
