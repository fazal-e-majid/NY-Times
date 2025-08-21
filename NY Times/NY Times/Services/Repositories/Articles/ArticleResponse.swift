//
//  ArticleResponse.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import Foundation

struct ArticleResponse: Decodable {
    var results: [ArticleData]
}

struct ArticleData: Decodable, Identifiable, Hashable {
    var id: Int
    var url: URL
    var publishedDate: String
    var title: String
    var abstract: String
    var source: String
    var section: String
    var byline: String
    var media: [ArticleMedia]
    
    var thumbnailURL: URL? { media.first?.metaData.last?.url }
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case publishedDate = "published_date"
        case title, abstract, source, section, byline, media
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decode(URL.self, forKey: .url)
        self.publishedDate = try container.decode(String.self, forKey: .publishedDate)
        self.title = try container.decode(String.self, forKey: .title)
        self.abstract = try container.decode(String.self, forKey: .abstract)
        self.source = try container.decode(String.self, forKey: .source)
        self.section = try container.decode(String.self, forKey: .section)
        self.byline = try container.decode(String.self, forKey: .byline)
        
        let media = try container.decode([ArticleMedia].self, forKey: .media)
        self.media = media.filter({ $0.type.lowercased() == "image" })
    }
    
    init(id: Int, url: URL, publishedDate: String, title: String, abstract: String, source: String, section: String, byline: String, media: [ArticleMedia] = []) {
        self.id = id
        self.url = url
        self.publishedDate = publishedDate
        self.title = title
        self.abstract = abstract
        self.source = source
        self.section = section
        self.byline = byline
        self.media = media
    }
}

struct ArticleMedia: Decodable, Hashable {
    var type: String
    var metaData: [MediaMetaData]
    
    enum CodingKeys: String, CodingKey {
        case type
        case metaData = "media-metadata"
    }
}

struct MediaMetaData: Decodable, Hashable {
    let url: URL
}
