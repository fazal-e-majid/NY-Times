//
//  ArticleDataTests.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import XCTest
@testable import NY_Times

final class ArticleDataTests: XCTestCase {
    // Tests that the custom decoder only includes media of type "image".
    func testDecodingFiltersNonImageMedia() {
        let json = """
            {
                "id": 1,
                "url": "https://example.com/article1",
                "published_date": "2023-01-01",
                "title": "Test Article",
                "abstract": "This is an abstract.",
                "source": "Test Source",
                "section": "News",
                "byline": "By A. B. Author",
                "media": [
                    {
                        "type": "image",
                        "media-metadata": [
                            {"url": "https://example.com/image1.jpg"}
                        ]
                    },
                    {
                        "type": "video",
                        "media-metadata": [
                            {"url": "https://example.com/video1.mp4"}
                        ]
                    }
                ]
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let articleData = try! decoder.decode(ArticleData.self, from: json)
        
        XCTAssertEqual(articleData.media.count, 1, "Only one media item should be decoded, as the other is a video.")
        XCTAssertEqual(articleData.media.first?.type, "image", "The decoded media item should be an image.")
    }
    
    /// Tests that the thumbnailURL is correctly computed from the media data.
    func testThumbnailURL() {
        let mediaMetaData = [
            MediaMetaData(url: URL(string: "https://example.com/thumbnail.jpg")!)
        ]
        let article = ArticleData(id: 1, url: URL(string: "https://example.com")!, publishedDate: "2023-01-01", title: "Test", abstract: "Abstract", source: "Source", section: "Section", byline: "Byline", media: [ArticleMedia(type: "image", metaData: mediaMetaData)])
        
        let thumbnailURL = article.thumbnailURL
        
        XCTAssertEqual(thumbnailURL, URL(string: "https://example.com/thumbnail.jpg"), "The thumbnail URL should be the last URL in the media metadata.")
    }
    
    /// Tests that the thumbnailURL is nil if the media array is empty.
    func testThumbnailURLIsNilWhenMediaIsEmpty() {
        let article = ArticleData(id: 1, url: URL(string: "https://example.com")!, publishedDate: "2023-01-01", title: "Test", abstract: "Abstract", source: "Source", section: "Section", byline: "Byline", media: [])
        
        let thumbnailURL = article.thumbnailURL
        
        XCTAssertNil(thumbnailURL, "The thumbnail URL should be nil when there is no media.")
    }
}
