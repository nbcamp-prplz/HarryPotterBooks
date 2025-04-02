import Foundation

final class MockDataService: DataServiceProtocol {
    func fetchBooks() -> Result<Books, DataError> {
        let firstBookDTO = BookDTO(
            title: "First Book",
            author: "author",
            pages: 100,
            releaseDate: "2025-03-26",
            dedication: "dedication",
            summary: "summary",
            wiki: "wiki",
            chapters: [ChapterDTO(title: "title"), ChapterDTO(title: "title")]
        )
        let secondBookDTO = BookDTO(
            title: "Second Book",
            author: "author",
            pages: 100,
            releaseDate: "2025-03-26",
            dedication: "dedication",
            summary: "summary",
            wiki: "wiki",
            chapters: [ChapterDTO(title: "title"), ChapterDTO(title: "title")]
        )
        let books: Books = [
            Book(from: firstBookDTO, with: 1),
            Book(from: secondBookDTO, with: 2),
        ]

        return .success(books)
    }
}
