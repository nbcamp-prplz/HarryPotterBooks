//
//  BookModel.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import Foundation
import UIKit

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
    let release_date: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Title]
}

struct Title: Decodable {
    let title: String
}
