//
//  BookModel.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import Foundation

struct BookResponse: Decodable {
    let data: [BookData]
}

struct BookData: Decodable {
    let attributes: Book
}

struct Book: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Title]
    
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
}

struct Title: Decodable {
    let title: String
}
