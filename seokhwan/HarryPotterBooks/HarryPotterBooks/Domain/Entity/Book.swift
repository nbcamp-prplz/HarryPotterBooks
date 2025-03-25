import Foundation

typealias Books = [Book]

struct Book: Codable {
    let seriesNumber: Int
    let title: String
    let author: String
    let pages: Int
    let releaseDate: Date
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: Chapters

    init(from dto: BookDTO, with seriesNumber: Int) {
        self.seriesNumber = seriesNumber
        title = dto.title
        author = dto.author
        pages = dto.pages
        releaseDate = Date.from(dateString: dto.releaseDate, with: "yyyy-MM-dd") ?? Date()
        dedication = dto.dedication
        summary = dto.summary
        wiki = dto.wiki
        chapters = dto.chapters.map { Chapter(from: $0) }
    }
}

typealias Chapters = [Chapter]

struct Chapter: Codable {
    let title: String

    init(from dto: ChapterDTO) {
        title = dto.title
    }
}
