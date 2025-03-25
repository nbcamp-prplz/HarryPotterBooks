import Foundation

struct BooksResponseDTO: Codable {
    let data: [BookAttributesDTO]
}

struct BookAttributesDTO: Codable {
    let attributes: BookDTO
}

struct BookDTO: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [ChapterDTO]

    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

struct ChapterDTO: Codable {
    let title: String
}
