//
//  Book.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

struct BookList: Decodable {
    let attributes: [Book]
}

struct Book: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case pages
        case releaseDate = "release_date"
        case dedication
        case summary
        case wiki
        case chapters
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.dedication = try container.decode(String.self, forKey: .dedication)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.wiki = try container.decode(String.self, forKey: .wiki)
        self.chapters = try container.decode([Chapter].self, forKey: .chapters)
    }
}

struct Chapter: Decodable {
    let title: String
}
