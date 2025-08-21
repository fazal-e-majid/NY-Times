//
//  ArticleItemView.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import SwiftUI
import SDWebImageSwiftUI

/// A single article view
struct ArticleItemView: View {
    let article: ArticleData
    
    var body: some View {
        VStack(spacing: 20) {
            WebImage(url: article.thumbnailURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipped()
            .overlay(alignment: .bottomTrailing) {
                Text("- "+article.source)
                    .font(.appRegular(17))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.black)
                    )
                    .offset(x: -12, y: -12)
            }
            
            VStack(spacing: 14) {
                Text(article.title)
                    .font(.appBold(20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(article.abstract)
                    .font(.appRegular(17))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(article.byline)
                        .font(.appRegular(15))
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    Text(article.publishedDate)
                        .font(.appRegular(15))
                }
            }
            .foregroundColor(.appSecondary)
            .padding(.horizontal)
            
        }
        .padding(.bottom, 26)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 7, x: 0, y: 2)
        }
    }
}

#Preview {
    ArticleItemView(article: ArticleData(
        id: 1,
        url: URL(string: "https://static01.nyt.com/images/2025/08/19/multimedia/18dc-takeaways-sub-top-art/19putin-trump-header-wtpq-mediumThreeByTwo440.jpg")!,
        publishedDate: "2025-08-18",
        title: "5 Takeaways From Trump’s Meeting With Zelensky and European Leaders",
        abstract: "The leaders presented a relatively united front and appeared to agree on the next steps in the effort to halt the fighting between Ukraine and Russia. But much remained unresolved.",
        source: "New York Times",
        section: "U.S.",
        byline: "By Luke Broadwater and Neil MacFarquhar")
    )
    .padding(.horizontal)
}
