//
//  Data.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/25/25.
//

import Foundation

struct Chapter: Codable {
    let title: String
}

struct BookAttributes: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

struct Book: Codable {
    let attributes: BookAttributes
}

struct BookData: Codable {
    let data: [Book]
}
