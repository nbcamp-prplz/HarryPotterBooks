//
//  Book.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

struct BookResponse: Decodable {
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
        self.dedication = try container.decode(String.self, forKey: .dedication)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.wiki = try container.decode(String.self, forKey: .wiki)
        self.chapters = try container.decode([Chapter].self, forKey: .chapters)
        
        // '1998-07-02' 형태로 되어있는 Json 데이터를 변형하여 'June 26, 1997' 형태로 표시
        let releaseString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // String -> Date 타입으로 변환
        guard let date = dateFormatter.date(from: releaseString) else {
            self.releaseDate = "Formmating Error"
            return
        }
        
        // '1998-07-02'-> 'June 26, 1997' 변환(Date -> String)
        self.releaseDate = date.formatted(date: .abbreviated, time: .omitted)
    }
}

struct Chapter: Decodable {
    let title: String
}
