//
//  ArticleDetailView.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import SwiftUI

/// Article Details Screen
struct ArticleDetailView: View {
    let articleData: ArticleData
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            WebView(url: articleData.url)
                .navigationTitle("Article Detail")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ArticleDetailView(articleData: ArticleData(
        id: 1,
        url: URL(string: "https://www.nytimes.com/2025/08/19/business/the-race-to-rescue-pbs-and-npr-stations.html")!,
        publishedDate: "2025-08-18",
        title: "5 Takeaways From Trump’s Meeting With Zelensky and European Leaders",
        abstract: "The leaders presented a relatively united front and appeared to agree on the next steps in the effort to halt the fighting between Ukraine and Russia. But much remained unresolved.",
        source: "New York Times",
        section: "U.S.",
        byline: "By Luke Broadwater and Neil MacFarquhar"
    ))
}
